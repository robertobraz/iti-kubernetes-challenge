# hpa-monitor-graph.ps1

# Dashboard HPA com barras de CPU e Memória + Teste de escala automático

# Configurações

$HPA_NAME = "iti-kotlin-iti-kotlin"
$DEPLOYMENT_LABEL = "app.kubernetes.io/instance=iti-kotlin"
$CHECK_INTERVAL = 3       # segundos entre atualizações do dashboard
$MAX_WAIT = 300           # tempo máximo de espera para escalar
$MIN_WAIT = 60            # tempo mínimo mantendo a carga
$BAR_WIDTH = 30           # largura das barras no terminal

# Funções de cores

function Get-Color($value) {
if ($value -ge 80) { return "Red" }
elseif ($value -ge 50) { return "Yellow" }
else { return "Green" }
}

function Draw-Bar($value, $maxValue, $width) {
$filled = [math]::Round($value / $maxValue * $width)
$empty = $width - $filled
return ("█" * $filled) + (" " * $empty)
}

# Seleciona pod para teste

$POD = kubectl get pod -l $DEPLOYMENT_LABEL -o jsonpath='{.items[0].metadata.name}'
Write-Host "Usando pod para teste: $POD"

# Gera carga de CPU no pod

Write-Host "Gerando carga de CPU..."
kubectl exec -it $POD -- /bin/sh -c "yes > /dev/null &"

$startTime = Get-Date
$hpaMaxReached = $false

while ($true) {
Clear-Host
Write-Host "===== HPA & Pod Metrics Dashboard (Barras) =====" -ForegroundColor Cyan
Write-Host ""

```
# Pega HPA
$hpa = kubectl get hpa $HPA_NAME -o json | ConvertFrom-Json
if ($hpa) {
    $currentReplicas = $hpa.status.currentReplicas
    $desiredReplicas = $hpa.status.desiredReplicas
    $minReplicas = $hpa.spec.minReplicas
    $maxReplicas = $hpa.spec.maxReplicas
    $cpuTarget = $hpa.spec.metrics[0].resource.target.averageUtilization
    $cpuCurrent = $hpa.status.currentMetrics[0].resource.current.averageUtilization

    Write-Host "HPA: $HPA_NAME" -ForegroundColor Yellow
    Write-Host "Replicas: $currentReplicas / $desiredReplicas (Min: $minReplicas, Max: $maxReplicas)"
    Write-Host "CPU usage: $cpuCurrent% / $cpuTarget%" 
}

# Métricas dos pods
$pods = kubectl top pods --no-headers | ForEach-Object {
    $fields = $_ -split '\s+'
    [PSCustomObject]@{
        Pod    = $fields[0]
        CPU    = [int]($fields[1] -replace "m","")
        Memory = [int]($fields[2] -replace "[^0-9]","")
    }
}

foreach ($pod in $pods) {
    $cpuColor = Get-Color($pod.CPU)
    $memColor = Get-Color($pod.Memory)

    $cpuBar = Draw-Bar $pod.CPU 100 $BAR_WIDTH
    $memBar = Draw-Bar $pod.Memory 1024 $BAR_WIDTH # assumindo max 1Gi

    Write-Host ("{0,-35} CPU: [{1}] {2}%" -f $pod.Pod, $cpuBar, $pod.CPU) -ForegroundColor $cpuColor
    Write-Host ("{0,-35} MEM: [{1}] {2}Mi" -f "", $memBar, $pod.Memory) -ForegroundColor $memColor
}

# Checa se atingiu máximo de replicas
if ($currentReplicas -ge $maxReplicas -and -not $hpaMaxReached) {
    Write-Host "`nMáximo de pods atingido! Mantendo carga por $MIN_WAIT segundos..." -ForegroundColor Magenta
    $hpaMaxReached = $true
    Start-Sleep -Seconds $MIN_WAIT

    # Para a carga
    Write-Host "Parando carga de CPU..." -ForegroundColor Cyan
    kubectl exec -it $POD -- /bin/sh -c "pkill yes"
    Write-Host "Carga parada. Aguardando HPA reduzir pods..." -ForegroundColor Cyan
}

# Verifica se HPA voltou ao mínimo após parar a carga
if ($hpaMaxReached -and $currentReplicas -le $minReplicas) {
    Write-Host "`nHPA voltou para o mínimo de pods!" -ForegroundColor Green
    break
}

# Timeout máximo
if ((Get-Date) - $startTime -gt (New-TimeSpan -Seconds $MAX_WAIT)) {
    Write-Host "`nTempo máximo de espera atingido." -ForegroundColor Red
    kubectl exec -it $POD -- /bin/sh -c "pkill yes"
    break
}

Start-Sleep -Seconds $CHECK_INTERVAL
```

}

Write-Host "`n✅ Teste HPA completo!" -ForegroundColor Cyan

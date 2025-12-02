# -------------------------------
# HPA Test Automatizado - PowerShell
# -------------------------------

# Configurações
$DEPLOYMENT_LABEL = "app.kubernetes.io/instance=iti-kotlin"
$CHECK_INTERVAL = 5       # segundos entre verificações HPA
$MAX_WAIT = 300           # tempo máximo de espera para escala (s)
$MIN_WAIT = 60            # tempo mínimo de espera antes de parar a carga (s)

# 1️⃣ Seleciona o primeiro pod do deployment
$POD = kubectl get pod -l $DEPLOYMENT_LABEL -o jsonpath='{.items[0].metadata.name}'
Write-Host "Usando pod para teste: $POD"

# 2️⃣ Gera carga de CPU dentro do pod
Write-Host "Gerando carga de CPU..."
kubectl exec -it $POD -- /bin/sh -c "yes > /dev/null &"

# 3️⃣ Espera o HPA escalar
$startTime = Get-Date
while ($true) {
    $hpa = kubectl get hpa -o json | ConvertFrom-Json
    $hpaTarget = ($hpa.items | Where-Object { $_.metadata.name -eq "iti-kotlin-iti-kotlin" })
    $currentReplicas = [int]$hpaTarget.status.currentReplicas
    $maxReplicas = [int]$hpaTarget.spec.maxReplicas

    Write-Host "HPA: $currentReplicas / $maxReplicas pods"

    if ($currentReplicas -ge $maxReplicas) {
        Write-Host "Máximo de pods atingido!"
        break
    }

    if ((Get-Date) - $startTime -gt (New-TimeSpan -Seconds $MAX_WAIT)) {
        Write-Host "Tempo máximo de espera atingido. Continuando..."
        break
    }

    Start-Sleep -Seconds $CHECK_INTERVAL
}

# 4️⃣ Mantém carga por um tempo mínimo
Write-Host "Mantendo carga por $MIN_WAIT segundos..."
Start-Sleep -Seconds $MIN_WAIT

# 5️⃣ Para a carga de CPU
Write-Host "Parando carga de CPU..."
kubectl exec -it $POD -- /bin/sh -c "pkill yes"

# 6️⃣ Observa HPA reduzir os pods
Write-Host "Aguardando HPA reduzir pods para o mínimo..."
while ($true) {
    $hpaTarget = kubectl get hpa -o json | ConvertFrom-Json | Select-Object -ExpandProperty items | Where-Object { $_.metadata.name -eq "iti-kotlin-iti-kotlin" }
    $currentReplicas = [int]$hpaTarget.status.currentReplicas
    $minReplicas = [int]$hpaTarget.spec.minReplicas

    Write-Host "HPA: $currentReplicas / $minReplicas pods"

    if ($currentReplicas -le $minReplicas) {
        Write-Host "HPA voltou para o mínimo de pods!"
        break
    }

    Start-Sleep -Seconds $CHECK_INTERVAL
}

Write-Host "✅ Teste HPA completo!"

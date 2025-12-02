# hpa-monitor.ps1
# Dashboard HPA com cores independentes para CPU e Memória
# Pressione Ctrl+C para parar

$interval = 5  # segundos entre atualizações
$hpaName = "iti-kotlin-iti-kotlin"

function Get-Color($value) {
    if ($value -ge 80) { return "Red" }
    elseif ($value -ge 50) { return "Yellow" }
    else { return "Green" }
}

function Get-Alert($value) {
    if ($value -ge 90) { return "[HOT]" }
    elseif ($value -ge 80) { return "[ALERT]" }
    else { return "" }
}

while ($true) {
    Clear-Host
    Write-Host "===== HPA & Pod Metrics Dashboard =====" -ForegroundColor Cyan
    Write-Host ""

    # Pega HPA
    $hpa = kubectl get hpa $hpaName -o json | ConvertFrom-Json

    if ($hpa) {
        $currentReplicas = $hpa.status.currentReplicas
        $desiredReplicas = $hpa.status.desiredReplicas
        $minReplicas = $hpa.spec.minReplicas
        $maxReplicas = $hpa.spec.maxReplicas
        $cpuTarget = $hpa.spec.metrics[0].resource.target.averageUtilization
        $cpuCurrent = $hpa.status.currentMetrics[0].resource.current.averageUtilization

        Write-Host "HPA: $hpaName" -ForegroundColor Yellow
        Write-Host "Min replicas: $minReplicas, Max replicas: $maxReplicas"
        Write-Host "Current replicas: $currentReplicas, Desired replicas: $desiredReplicas"
        Write-Host "CPU usage: $cpuCurrent% / $cpuTarget%" 
    } else {
        Write-Host "HPA $hpaName não encontrada." -ForegroundColor Red
    }

    Write-Host ""
    Write-Host "Pods e consumo de recursos:" -ForegroundColor Green

    $pods = kubectl top pods --no-headers | ForEach-Object {
        $fields = $_ -split '\s+'
        [PSCustomObject]@{
            Pod    = $fields[0]
            CPU    = $fields[1]
            Memory = $fields[2]
        }
    }

    foreach ($pod in $pods) {
        $cpuValue = [int]($pod.CPU -replace "m","")
        $memValue = [int]($pod.Memory -replace "[^0-9]","") # remove unidade

        $cpuColor = Get-Color($cpuValue)
        $memColor = Get-Color($memValue)

        $cpuAlert = Get-Alert($cpuValue)
        $memAlert = Get-Alert($memValue)

        # Exibe CPU
        Write-Host ("{0,-35} CPU: {1,5}% {2}" -f $pod.Pod, $cpuValue, $cpuAlert) -ForegroundColor $cpuColor
        # Exibe Memory
        Write-Host ("{0,-35} Memory: {1,5}Mi {2}" -f "", $memValue, $memAlert) -ForegroundColor $memColor
    }

    Write-Host ""
    Start-Sleep -Seconds $interval
}

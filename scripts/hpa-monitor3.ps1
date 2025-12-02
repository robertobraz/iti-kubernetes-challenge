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
    Write-Host "Min replicas: $minReplicas, Max replicas: $maxReplicas"
    Write-Host "Current replicas: $currentReplicas, Desired replicas: $desiredReplicas"
    Write-Host "CPU usage: $cpuCurrent% / $cpuTarget%" 
}

# Pega métricas dos pods
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
    $memValue = [int]($pod.Memory -replace "[^0-9]","")

    $cpuColor = Get-Color($cpuValue)
    $memColor = Get-Color($memValue)

    $cpuAlert = Get-Alert($cpuValue)
    $memAlert = Get-Alert($memValue)

    Write-Host ("{0,-35} CPU: {1,5}% {2}" -f $pod.Pod, $cpuValue, $cpuAlert) -ForegroundColor $cpuColor
    Write-Host ("{0,-35} Memory: {1,5}Mi {2}" -f "", $memValue, $memAlert) -ForegroundColor $memColor
}

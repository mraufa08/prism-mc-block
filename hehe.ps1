# Nama proses Prism Launcher
$processName = "prismlauncher"

while ($true) {
    Start-Sleep -Seconds 5

    # Cek apakah Prism Launcher sedang jalan
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($process) {
        $battery = Get-WmiObject -Class Win32_Battery
        $chargingStatus = $battery.BatteryStatus
        $chargePercentage = $battery.EstimatedChargeRemaining

        # Tidak charging ➔ stop + notifikasi
        if (($chargingStatus -eq 1) -or ($chargingStatus -eq 3)) {
           
            Stop-Process -Name $processName -Force
        }

        # Charging tapi < 95%  
        elseif ($chargePercentage -lt 95) {
            Stop-Process -Name $processName -Force
        }

        # Charging dan >= 95% 
        elseif ($chargePercentage -ge 95) {
            Start-Sleep -Seconds 2 # beri jeda 2 detik untuk open prism
        }
    }
}

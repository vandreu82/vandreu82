# Cambiar entre configuraciones IP
$adapterName = "Ethernet"  # Cambia esto si tu adaptador tiene otro nombre

function Set-DHCP {
    Write-Host "Cambiando a configuración automática (DHCP)..."
    netsh interface ip set address name="$adapterName" source=dhcp
    netsh interface ip set dns name="$adapterName" source=dhcp
}

function Set-Static1 {
    Write-Host "Cambiando a configuración IP fija #1..."
    netsh interface ip set address name="$adapterName" static 192.168.1.100 255.255.255.0 192.168.1.1
    netsh interface ip set dns name="$adapterName" static 8.8.8.8
}

function Set-Static2 {
    Write-Host "Cambiando a configuración IP fija #2..."
    netsh interface ip set address name="$adapterName" static 10.0.0.100 255.255.255.0 10.0.0.1
    netsh interface ip set dns name="$adapterName" static 1.1.1.1
}

# Menú de selección
Write-Host "Selecciona la configuración de red:"
Write-Host "1. DHCP (automática)"
Write-Host "2. IP Fija #1 (192.168.1.100)"
Write-Host "3. IP Fija #2 (10.0.0.100)"
$choice = Read-Host "Ingresa tu opción (1-3)"

switch ($choice) {
    "1" { Set-DHCP }
    "2" { Set-Static1 }
    "3" { Set-Static2 }
    default { Write-Host "Opción no válida" }
}

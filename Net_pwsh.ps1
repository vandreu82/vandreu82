# Nombre del adaptador de red
$adapterName = "Ethernet"  # Cambia esto según el nombre de tu adaptador

function Set-DHCP {
    Write-Host "Cambiando a configuración automática (DHCP)..."
    # IP automática
    Set-NetIPInterface -InterfaceAlias $adapterName -Dhcp Enabled -ErrorAction SilentlyContinue
    Remove-NetIPAddress -InterfaceAlias $adapterName -Confirm:$false -ErrorAction SilentlyContinue
    # DNS automático
    Set-DnsClientServerAddress -InterfaceAlias $adapterName -ResetServerAddresses
}

function Set-Static1 {
    Write-Host "Cambiando a configuración IP fija #1..."
    # IP fija
    New-NetIPAddress -InterfaceAlias $adapterName -IPAddress 192.168.1.100 -PrefixLength 24 -DefaultGateway 192.168.1.1 -ErrorAction SilentlyContinue
    # DNS fijo
    Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses 8.8.8.8
}

function Set-Static2 {
    Write-Host "Cambiando a configuración IP fija #2..."
    New-NetIPAddress -InterfaceAlias $adapterName -IPAddress 10.0.0.100 -PrefixLength 24 -DefaultGateway 10.0.0.1 -ErrorAction SilentlyContinue
    Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses 1.1.1.1
}

# Menú
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

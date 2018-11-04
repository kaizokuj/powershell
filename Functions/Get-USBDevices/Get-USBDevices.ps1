Function Get-USBDevices {

    Get-WmiObject Win32_USBControllerDevice |%{[wmi]($_.Dependent)} | Sort Description,DeviceID,Manufacturer | ft Description,DeviceID,Manufacturer -auto
    New-Alias -Name "lsusb" -Value "Get-USBDevices"

}
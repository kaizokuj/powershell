Function Get-Helpfiles {

[CmdletBinding()]

PARAM (
    
[STRING[]]$Modules = "*",
[STRING]$Target = "C:\Cmdlets\",
[STRING[]]$Commands = "*",
[SWITCH]$NoUpdate

)

    function GetTime {
        
            Return (Get-Date).ToShortTimeString()
    }


if(!($NoUpdate)) {

    Write-Host "[" (GetTime) "] Updating Help Files ..."

    ForEach ($Modules in $Module) {

        Update-Help -Module $Module

        Write-Host -ForegroundColor green "[" (GetTime) "] Updated help files for Module: $module"
    
    }

}

if ($Modules -ne "*") {

    write-host "[" (GetTime) "] Modules to be used : $Modules"

}

if (Test-Path $Target) {

    Write-Host "[" (getTime) "] The system will now create your helpfiles."

    Foreach ($Module in $Modules) {

        New-Item -ItemType Directory -Path "$Target" -Name "$Module" | Out-Null

        Foreach ($Command in $Commands) {

                       
            Get-Help -full $Name | Out-File "$Target\$Module\$Name.txt"

        }

        write-host -foregroundcolor green "[" (GetTime) "] Succesfully created help files for: $Module"

    }

}

Else {

    Write-Host -ForegroundColor Yellow "[" (GetTime) "] No such directory was found, creating now ..."

    New-Item -Type Directory -Path "$Target" -Name "$Module" | Out-Null

    Write-Host "[" (getTime) "] The system will now create your helpfiles."

    Foreach ($Module in $Modules) {

        New-Item -ItemType Directory -Path "$Target" -Name "$Module" | Out-Null

        Foreach ($Command in $Commands) {

                       
            Get-Help -full $Name | Out-File "$Target\$Module\$Name.txt"

        }

        write-host -foregroundcolor green "[" (GetTime) "] Succesfully created help files for: $Module"

    }


}


}

Get-Helpfiles -Modules AudioDeviceCmdlets,enhancedhtml2
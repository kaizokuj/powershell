function Reload-Module {
<#
.SYNOPSIS
Reloads an already loaded module from it's original path.
.DESCRIPTION
The cmdlet finds the path a module is loaded from then proceeds to use remove-module and Import-Module.
.NOTES
This cmdlet is intended for development purposes, to eliminate the need to manually reload a function one is developing.
.EXAMPLE
Reload-Module ActiveDirectory
Attempts to unload and import the ActiveDirectory Module.
.EXAMPLE
Reload-Module ActiveDirectory, Plaster
This command will reload both ActiveDirectory and Plaster.
.EXAMPLE
Get-module -Name * | Reload-Module
Reloads all currently loaded modules.
.LINK
Import-Module
Remove-Module
#>
    [CmdletBinding(ConfirmImpact="Medium",SupportsShouldProcess)]

    param (

        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        [STRING[]]$Modules

    )

    BEGIN {}
    PROCESS {
        ForEach ($module in $Modules) {
        
            $ModulePath = Get-Module -Name $Module
            remove-module $module -Verbose
            Write-Host "Removed Module: $Module"
            Import-Module $ModulePath.Path -Verbose
            Write-host "Loaded Module from Path:" $ModulePath.Path
            write-Host "Reload Succesfull"

        }
    }

    END {}

}

Import-module ../Scripts/ReloadTest.ps1

Reload-Module Reload-Test
   


#Add Error Handling and a decent way to see if it was succesfull
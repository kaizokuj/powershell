function Reload-Module {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        [STRING[]]$Module

    )

    $ModulePath = Get-Module -Name $Module
    remove-module $module
    Write-Host "Removed Module: $Module"
    Import-Module $ModulePath.Path
    Write-host "Loaded Module from Path:" $ModulePath.Path

    write-Host "Reload Succesfull"
}

#Add Error Handling and a decent way to see it was succesfull
function Reload-Module {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        [STRING[]]$Modules

    )

    ForEach ($module in $Modules) {
    
        $ModulePath = Get-Module -Name $Module
        remove-module $module
        Write-Host "Removed Module: $Module"
        Import-Module $ModulePath.Path
        Write-host "Loaded Module from Path:" $ModulePath.Path

        write-Host "Reload Succesfull"

    }
}
   


#Add Error Handling and a decent way to see if it was succesfull
#Accepts multiple inputs if ran standalone but not if piped, needs BEGIN, PROCESS, END (Don Jones ToolMaking, Youtube)
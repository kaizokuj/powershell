Function get-Helpfiles {
<#
.SYNOPSIS
Creates .txt file version of one or more Get-Help commands.
.DESCRIPTION
The cmdlet tries to update help files then for each command in the specified module creates text files with full usage documentation.
.NOTES
If no module or command is specified the command will create help files for ALL commands in ALL modules.
.EXAMPLE
get-Helpfiles
Creates help files for every command in every available module.
.EXAMPLE
get-helpfiles -Module dnsserver
Creates help files for all commands in the "dnsserver" module.
.EXAMPLE
get-helpfiles -Module dnsserver -command Add-DnsServerClientSubnet
Creates help file only for "Add-DnsServerClientSubnet" in the "dnsserver" module
.EXAMPLE
get-helpfiles -NoUpdate
Creates all command help files while skipping the updating of help files.
.LINK
Get-Command
Get-help 

#>
[CmdletBinding()]

PARAM (
#[Parameter(Mandatory=$true,Position=0,ValueFromPipeline=$false,ValueFromPipelineByPropertyName=$false)]
[STRING]$Module = "*",
#[Parameter(Mandatory=$true,Position=1,ValueFromPipeline=$false,ValueFromPipelineByPropertyName=$false)]
[STRING]$Target = "C:\Cmdlets\",
#[Parameter(Mandatory=$true,Position=2,ValueFromPipeline=$false,ValueFromPipelineByPropertyName=$false)]
[STRING]$Command = "*",
#[Parameter(Mandatory=$false,Position=3,ValueFromPipeline=$false,ValueFromPipelineByPropertyName=$false)]
[SWITCH]$NoUpdate

)

function GetTime {
    
        Return (Get-Date).ToShortTimeString()
}

If(!($NoUpdate)){

    write-host "[" (GetTime) "] Updating Help Files ..."

    update-help -Module $Module

    write-host -foregroundcolor green "[" (GetTime) "] Help Files Succesfully Updated!"

}
    
    if ($Module -ne "*" ) {

        write-host "[" (GetTime) "] Module to be used : $Module"

    }


    if (TEST-PATH $Target) {

        Write-Host "[" (getTime) "] The system will now create your helpfiles."

        Get-Command -Module $Module $command | ?{$_.commandtype -ne "Alias"} | ?{$_.ModuleName -ne ""} | %{$Name = $_.Name; Get-Help -full $Name | Out-File "$target\$Name.txt"}

        write-host -foregroundcolor green "[" (GetTime) "] Your help files were created in $target"

    }

else {

   write-host -foregroundcolor Yellow "[" (GetTime) "] No such directory was found, creating now ..."
   
   mkdir $Target | out-null

   Write-Host "[" (GetTime) "] The system will now create your helpfiles."
   
   (Get-Command -Module $Module $command | ?{$_.commandtype -ne "Alias"}) | ?{$_.ModuleName -ne ""} | %{$Name = $_.Name; Get-Help -full $Name | Out-File "$target\$Name.txt"}
   
   write-host -foregroundcolor green "[" (GetTime) "] Your help files were created in $target"

    }

}


#Noticed that if you specify a command, rather then updating that specific command or it's module, it tries to update all, FIX.
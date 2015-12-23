[CmdletBinding()]

PARAM (

[STRING]$Module = "*",
[STRING]$Target = "C:\Cmdlets\",
[STRING]$Command = "*",
[SWITCH]$NoUpdate,
[SWITCH]$Sort

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
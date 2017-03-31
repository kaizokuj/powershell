Funtion Get-ADUserLastLogin {

[CmdletBinding()]

#This is a script designed to quickly lookup last user login
#This script is not working yet || Might now, needs to be tested

PARAM (

[STRING]$SAN

)

 
get-aduser -Identity $SAN -Properties LastLogon, LastlogonTimestamp | Select-Object -ExpandProperty LastLogon, LastlogonTimestamp

}
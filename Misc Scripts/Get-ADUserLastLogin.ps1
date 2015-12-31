[CmdletBinding()]

#This is a script designed to quickly lookup last user login
#This script is not working yet

PARAM (

[STRING]$email = "*"
)

 
get-aduser -filter {LastLogon -like "*"}
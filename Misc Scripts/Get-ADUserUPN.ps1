[CmdletBinding()]

#This is a script designed to quickly lookup User Principle Names

PARAM (

[STRING]$UPN = "*"
)


Get-ADUser -filter {(UserPrincipalName -like $UPN)}| sort-object | format-table -Property Name, UserPrincipalName

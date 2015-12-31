[CmdletBinding()]

#This is a script designed to quickly lookup user email addresses

PARAM (

[STRING]$email = "*"
)

 
Get-ADUser -filter {mail -like $email} -Properties EmailAddress| sort-object |  format-table -Property Name, Emailaddress

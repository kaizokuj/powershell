[CmdletBinding()]

#This is a script designed to quickly lookup who is in a particular department

PARAM (

[STRING]$department
)


Get-ADUser -Filter {(Department -Like $department)} | sort-object | format-table -Property Name

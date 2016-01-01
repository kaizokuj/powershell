[CmdletBinding()]

#This is a script designed to quickly lookup who is in a particular department

PARAM (

[STRING]$department = "*"
)

#By using the -properties switch we can add other properties that normally wouldn't be shown
Get-ADUser -Filter {Department -Like $department} -properties Department| sort-object | format-table -Property Name, Department

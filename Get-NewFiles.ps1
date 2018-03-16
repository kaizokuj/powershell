function Get-NewFiles {

    param (



    )

}

#Get-ChildItem -recurse | where {$_.Creationtime -gt ((get-date).adddays(-7)) } | select name
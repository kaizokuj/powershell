$Files = Get-ChildItem -Recurse

$i = 0
Foreach ($File in $Files) {

    $i++
    Write-Progress -Activity "Indexing files" -Status "Indexing FileNr: $i" -PercentComplete ($i / $Files.count * 100)

}
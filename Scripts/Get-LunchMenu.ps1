$URI = "http://www.grillhuset.se"
$HTML = Invoke-WebRequest -URI $URI

[STRING[]]$days = @("måndag","tisdag","onsdag","torsdag","fredag")
[STRING[]]$UniqueIDS = @(105..110)

ForEach ($UniqueID in $UniqueIDS) {

    $result = $HTML.Parsedhtml.GetElementsByTagName('p') | Where-Object {$_.UniqueNumber -like "$UniqueID*"} | Select-Object -ExpandProperty OuterText 
    
    $result = $result.ToLower()
    $result = $result -replace '.-\)', '' 
    $result
}

#Format spacing first then edit casing after that?


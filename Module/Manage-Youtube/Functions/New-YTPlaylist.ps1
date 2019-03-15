Function New-YTPlaylist {

    param (

        [parameter(Mandatory=$True)]$Accesstoken,
        [parameter(Mandatory=$True)]$Name,
        [parameter(Mandatory=$False)]$Description = ""

    )

    <# $body = @{snippet=@{title="$Name"}} | convertto-json #>

    $body = @{snippet=@{
        title="$Name"
        description="$Description"
        }
    }


    Invoke-WebRequest -Uri "https://www.googleapis.com/youtube/v3/playlists?part=snippet" -Method Post -Body ($body | ConvertTo-Json) -Headers @{Authorization = "Bearer $accesstoken"} -ErrorVariable RespErr -ContentType "application/json"


}
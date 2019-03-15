Function Add-YTVideo {

    param (

        [parameter(Mandatory=$True)]$AccessToken,
        [parameter(Mandatory=$True)]$PlayListID,
        [parameter(Mandatory=$True,ValueFromPipeline = $true)][STRING[]]$VideoID

    )

    foreach ($item in $videoID) {

        $body = @{snippet=@{
            playlistId="$PlaylistID"
            resourceId=@{
               videoId=$item
               kind="youtube#video"
               }    
           }
       }

       Invoke-WebRequest -Uri "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet" -Method Post -Body ($body | convertto-json) -Headers @{Authorization = "Bearer $accesstoken"} -ErrorVariable RespErr -ContentType "application/json"

    }
}
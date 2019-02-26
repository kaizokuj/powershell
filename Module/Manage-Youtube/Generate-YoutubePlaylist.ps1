Function Generate-youtubePlaylist {

  <#   param (

        [parameter(Mandatory=$True)]$a

    ) #>

    $accesstoken = Get-Content ./accesstoken.txt

    $playlist = New-YoutubePlaylist -AccessToken $accesstoken -Name (get-date).ToShortDateString()
    $playlistID = $playlist.content | ConvertFrom-Json | select -exp id

    $newvideos = Get-NewYoutubeVideos -Accesstoken $accesstoken -ChannelID "UCT6iAerLNE-0J1S_E97UAuQ" -DaysOld 2

    foreach ($item in $newvideos.items) {

        $body = @{snippet=@{
            playlistId="$PlaylistID"
            resourceId=@{
               videoId=$item.id.videoid
               kind="youtube#video"
               }    
           }
       }

       Invoke-WebRequest -Uri "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet" -Method Post -Body ($body | convertto-json) -Headers @{Authorization = "Bearer $accesstoken"} -ErrorVariable RespErr -ContentType "application/json"


    }

}
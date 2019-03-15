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

Function New-YTPlaylist {

    param (

        [parameter(Mandatory=$True)]$Accesstoken,
        [parameter(Mandatory=$True)]$Name,
        [parameter(Mandatory=$False)]$Description = ""

    )

    $body = @{snippet=@{
        title="$Name"
        description="$Description"
        }
    }


    Invoke-WebRequest -Uri "https://www.googleapis.com/youtube/v3/playlists?part=snippet" -Method Post -Body ($body | ConvertTo-Json) -Headers @{Authorization = "Bearer $accesstoken"} -ErrorVariable RespErr -ContentType "application/json"


}

Function Get-YTVideo {

    param (

        [parameter(Mandatory=$True)]$Accesstoken,
        [parameter(Mandatory=$True)]$ChannelID,
        [parameter(Mandatory=$False)]$DaysOld = "1"

    )

    $PublishedDate = [Xml.XmlConvert]::ToString((get-date).AddDays(-$DaysOld),[Xml.XmlDateTimeSerializationMode]::Utc)

    $invokeURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=" + $ChannelID + "&publishedAfter=" + $PublishedDate + "&type=video"

    $results = Invoke-RestMethod -uri $invokeURL -Method Get -Headers @{Authorization = "Bearer $accesstoken"}

    foreach ($result in $results.items) {

        $props = @{'VideoID'=$result.id.videoid;
                    'Title'=$result.snippet.title;
                    'Description'=$result.snippet.description;
                    'PublishedAt'=$result.snippet.PublishedAt;
                    'ChannelTitle'=$result.snippet.ChannelTitle}

        $output = New-Object -TypeName psobject -Property $props

        $output
    }

}
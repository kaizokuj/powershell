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
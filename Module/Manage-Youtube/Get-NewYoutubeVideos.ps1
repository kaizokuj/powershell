Function Get-NewYoutubeVideos {

    param (

        [parameter(Mandatory=$True)]$Accesstoken,
        [parameter(Mandatory=$True)]$ChannelID,
        [parameter(Mandatory=$False)]$DaysOld = "1"

    )

    $PublishedDate = [Xml.XmlConvert]::ToString((get-date).AddDays(-$DaysOld),[Xml.XmlDateTimeSerializationMode]::Utc)

    $invokeURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=" + $ChannelID + "&publishedAfter=" + $PublishedDate + "&type=video"

    Invoke-RestMethod -uri $invokeURL -Method Get -Headers @{Authorization = "Bearer $accesstoken"}

# Possible to use .items property to do a foreach loop
}
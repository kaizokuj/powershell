Function Get-YTSubscriptions {

    param (

        [parameter(Mandatory=$True)]$Accesstoken

    )

        do {

            $invokeURL = "https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&maxResults=50&mine=true&pageToken=" + $NextPageToken
            $results = Invoke-RestMethod -uri $invokeURL -Method Get -Headers @{Authorization = "Bearer $accesstoken"}
            $NextPageToken = $results.NextPageToken

            foreach ($result in $results.items) {

                $props =  @{'Title'=$result.snippet.Title;
                            'Description'=$result.snippet.description;
                            'ChannelID'=$result.snippet.resourceId.channelId;
                            'SubscriptionID'=$result.id}

                $output = New-Object -TypeName psobject -Property $props

                $output

            }

        }

        until ($NextPageToken -like "")

    }
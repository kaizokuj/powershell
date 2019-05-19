Function Send-PushbulletMessage {

    [CmdletBinding(DefaultParameterSetName='Note')]
    Param (

        [parameter(Mandatory=$False)]$AccessToken = (get-content -Path "$home\Pushbullet_Access_Token.txt"),
        [parameter(Mandatory=$False,ParameterSetName = "Note")][SWITCH]$Note = $True,
        [Parameter(Mandatory=$True,ParameterSetName = "Link")][SWITCH]$Link,
        [Parameter(Mandatory=$True,ParameterSetName = "Link")]$URL,
        [Parameter(Mandatory=$True,ParameterSetName = "File")][SWITCH]$File,
        [Parameter(Mandatory=$True,ParameterSetName = "File")]$FileName,
        [Parameter(Mandatory=$True,ParameterSetName = "File")]$FileType,
        [Parameter(Mandatory=$True,ParameterSetName = "File")]$FileURL,
        [parameter(Mandatory=$True,ValueFromPipeline = $true)]$Message,
        [parameter(Mandatory=$False)]$Title

    )

    $APIURL = "https://api.pushbullet.com/v2/pushes"

    if ($File) {

        $Body = @{body="$Message"
                  type="file"
                  file_name="$FileName"
                  file_type="$FileType"
                  file_url="$FileURL"}

    }
    
    elseif ($Link) {

        if (!($title)) {
            
            $Title = "No Subject"

        }

        $Body = @{body="$Message"
                  type="link"
                  url="$URL"
                  title="$Title"}

    }

    else {

        if (!($title)) {
            
            $Title = "No Subject"

        }

        $Body = @{body="$Message"
                  type="note"
                  title="$Title"}

    }

    Try {

        Invoke-RestMethod -Method post -Uri "https://api.pushbullet.com/v2/pushes" -Headers @{Authorization = "Bearer $AccessToken"} -ContentType application/JSON -Body ($body | convertto-json)

    }

    Catch {

        Write-Host "Something went wrong: " $Error[0]

    }
}
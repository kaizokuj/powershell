Function Get-AuthToken {

    <#
    .SYNOPSIS
    Generates an authlink to be used for authenticating with the google API.
    .DESCRIPTION
    The script takes supplied values and generates a link the user can follow to get a 0Auth Authentication code.
    .EXAMPLE
    Get-AuthToken -ClientID "X" -Secret "Y" -RedirectURI "http://localhost/oauth2callback" -Scope "https://www.googleapis.com/auth/youtube"
    Generates a link that the user can follow to authenticate with the API, the code returned in the URL can then be used to fetch Access and Refresh tokens.
    
    .LINK
    Get-AccessToken
    Refresh-AccessToken
    #>
    
        [CmdletBinding(SupportsShouldProcess,DefaultParameterSetName='UserInput')]
    
        param (
    
            [parameter(Mandatory=$True, ParameterSetName = 'UserInput')]$ClientID,
            [parameter(Mandatory=$True, ParameterSetName = 'UserInput')]$Secret,
            [parameter(Mandatory=$True, ParameterSetName = 'UserInput')]$RedirectURI,        
            [parameter(Mandatory=$True)]$Scope,
            [parameter(Mandatory=$False)]$RequestURI = "https://www.googleapis.com/oauth2/v4/token",
            [parameter(Mandatory=$False, ParameterSetName = 'FileInput')]$ConfigurationFile,
            [parameter(Mandatory=$False)]$URL = "https://accounts.google.com/o/oauth2/auth?client_id="
    
    
        )

        If ($ConfigurationFile) {

            $JSON = Get-Content $ConfigurationFile | ConvertFrom-Json | select -exp web

            $ClientID = $JSON.client_id
            $Secret = $JSON.client_secret
            $RedirectURI = $JSON.redirect_uris[0]

        }
    
        $0authlink = $URL + $ClientID + "&scope=" + $Scope + "&response_type=code&redirect_uri=" + $RedirectURI + "&access_type=offline&approval_prompt=force"
    
        $0authlink
        
    }
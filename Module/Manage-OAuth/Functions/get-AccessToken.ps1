Function Get-AccessToken {

    <#
    .SYNOPSIS
    Creates Access and Refresh Tokens for use with the Google API
    .DESCRIPTION
    Uses the authentication code from Get-AuthToken to generate an Access and Refresh Token to be used when making calls to the API.
    .EXAMPLE
    Get-AccessToken -ClientID "X" -Secret "Y" -RedirectURI "http://localhost/oauth2callback"
    Generates Access and Refresh Tokens in the current folder.
    .EXAMPLE
    Get-AccessToken -ClientID "X" -Secret "Y" -RedirectURI "http://localhost/oauth2callback" -Path "C:\users\hdcase\Desktop"
    Generates Access and Refresh Tokens in the Specified folder.
    
    .LINK
    Get-AuthToken
    Refresh-AccessToken
    #>
    
    [CmdletBinding(SupportsShouldProcess,DefaultParameterSetName='UserInput')]
        param (
    
            [parameter(Mandatory=$True)]$Code,
            [parameter(Mandatory=$True, ParameterSetName = 'UserInput')]$ClientID,
            [parameter(Mandatory=$True, ParameterSetName = 'UserInput')]$Secret,
            [parameter(Mandatory=$True, ParameterSetName = 'UserInput')]$RedirectURI,
            [parameter(Mandatory=$False, ParameterSetName = 'FileInput')]$ConfigurationFile,
            [parameter(Mandatory=$False)]$RequestURI = "https://www.googleapis.com/oauth2/v4/token",
            [parameter(Mandatory=$False)]$Path = "."
    
        )

        If ($ConfigurationFile) {

            $JSON = Get-Content $ConfigurationFile | ConvertFrom-Json | select -exp web

            $ClientID = $JSON.client_id
            $Secret = $JSON.client_secret
            $RedirectURI = $JSON.redirect_uris[0]

        }
    
        $body = @{
    
            code=$Code;
            client_id=$ClientID;
            client_secret=$Secret;
            redirect_uri=$RedirectURI;
            grant_type="authorization_code";
        
        }
    
        $tokens = Invoke-RestMethod -Uri $requestUri -Method POST -Body $body
    
        Set-Content "$Path\RefreshToken.txt" $tokens.refresh_token
        Set-Content "$Path\AccessToken.txt" $tokens.access_token
    
    }
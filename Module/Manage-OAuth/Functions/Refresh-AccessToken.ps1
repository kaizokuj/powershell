Function Refresh-AccessToken {

    <#
    .SYNOPSIS
    Refreshes existing Access Token 
    .DESCRIPTION
    Uses the authentication code from Get-AuthToken to generate an Access and Refresh Token to be used when making calls to the API.
    .EXAMPLE
    Refresh-AccessToken -ClientID "X" -Secret "Y" -RefreshToken "ijhfdjibafbijaSDBIJH"
    Refreshes the Access Token using the provided refresh token, updating the access token file in the current directory.
    .EXAMPLE
    Refresh-AccessToken -ClientID "X" -Secret "Y" -Path "c:\users\hdcase\Desktop" -AccessTokenPath "C:\wmute\AccessToken.txt"
    Refreshes the Access Token using the refresh token in the path provided and updates the access token in the specified folder.
    
    .LINK
    Get-AuthToken
    Get-AccessToken
    #>
    
        [CmdletBinding(DefaultParameterSetName='FromPath')]
        param (
    
            [parameter(Mandatory=$True, ParameterSetName = 'UserInput')]$ClientID,
            [parameter(Mandatory=$True, ParameterSetName = 'UserInput')]$Secret,
            [parameter(Mandatory=$False, ParameterSetName = 'FromPath')]$Path = "./RefreshToken.txt",
            [parameter(Mandatory=$True, ParameterSetName = 'FromText')]$RefreshToken,
            [parameter(Mandatory=$False)]$AccessTokenPath = "./AccessToken.txt",
            [parameter(Mandatory=$False, ParameterSetName = 'FileInput')]$ConfigurationFile
    
        )

        If ($ConfigurationFile) {

            $JSON = Get-Content $ConfigurationFile | ConvertFrom-Json | select -exp web

            $ClientID = $JSON.client_id
            $Secret = $JSON.client_secret
            $RedirectURI = $JSON.redirect_uris[0]

        }
    
        if (!($RefreshToken)) {
    
            $RefreshToken = Get-Content $Path
    
        } 
    
        $refreshTokenParams = @{
            client_id = $ClientID;
            client_secret = $Secret;
            refresh_token = $RefreshToken;
            grant_type = "refresh_token";
           }
            
           $tokens = Invoke-RestMethod -Uri "https://www.googleapis.com/oauth2/v4/token" -Method POST -Body $refreshTokenParams
        
           Set-Content "$AccessTokenPath" $tokens.access_token
    }
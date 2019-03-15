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
            [parameter(Mandatory=$True)][]$Scope,
            [parameter(Mandatory=$False)]$RequestURI = "https://www.googleapis.com/oauth2/v4/token",
            [parameter(Mandatory=$False, ParameterSetName = 'FileInput')]$ConfigurationFile,
            [parameter(Mandatory=$False)]$URL = "https://accounts.google.com/o/oauth2/auth?client_id="
    
    
        )

        If ($ConfigurationFile) {

            $JSON = Get-Content $ConfigurationFile | ConvertFrom-Json | select -exp web

            $ClientID = $JSON.client_id
            $Secret = $JSON.client_secret
            $RedirectURI = $JSON.redirect_uris

        }
    
        $0authlink = $URL + $ClientID + "&scope=" + $Scope + "&response_type=code&redirect_uri=" + $RedirectURI + "&access_type=offline&approval_prompt=force"
    
        $0authlink
        
    }

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
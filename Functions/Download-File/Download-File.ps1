Function Download-File {

    [CmdletBinding(SupportsShouldProcess)]

    param (

        [Parameter(Mandatory=$true)][STRING]$url,
        [Parameter(Mandatory=$true)][STRING]$Path     

    )

    Set-Alias -Name "Download-File" -Value "curl"
    Set-Alias -Name "Download-File" -Value "wget"

    [DATETIME]$TimeStarted = (get-date).ToShorttimestring()
    $BITSStatus = (Get-Service BITS).Status
    Write-Verbose "BITS is: $BITSStatus"

  
    if (!($BITSStatus -eq "Stopped")) {

        Write-Verbose "Using BITS download method"
        Import-Module BitsTransfer
        
        try {

        Start-BitsTransfer -Source $url -Destination $Path
        
        }
    
        catch {

            Write-Host $Error[0]

        }
    }

    else {

        Write-verbose "Using .NET download method"
        Try {

        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($url, $path)

        }
    
        Catch {

            Write-Host $Error[0]

        }
        #Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

    }
}
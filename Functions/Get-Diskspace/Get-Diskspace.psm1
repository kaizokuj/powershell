Function Get-DiskSpace {

<#
.SYNOPSIS
Will calculate disk sizes.
.DESCRIPTION
The cmdlet will check disk usage and availibility in specified disks
.EXAMPLE
Get-DiskSpace -Drive D:
Will show disk usage statistics for drive "D:"
.EXAMPLE
Get-DiskSpace -All
Will show disk usage statistics for all drives

.LINK
Get-ciminstance
#>

    [CmdletBinding(DefaultParameterSetName='B')]
    param (

        [Parameter(Mandatory=$True, ParameterSetName="A")]
        [SWITCH]$All,
        [Parameter(Mandatory=$True, Position=0, ParameterSetName="B")]
        [STRING]$Drive

    )

    
    if (($All) -and (!($Drive))) {

        $Disks = Get-CimInstance Win32_LogicalDisk

        foreach ($disk in $disks) {

            $props = [ordered]@{'Drive' = $disk.DeviceID;
                                'VolumeName' = $disk.VolumeName;
                                'Size (GB)' =  [math]::Round($disk.Size / 1GB);
                                'Available (GB)' =  [math]::Round($disk.FreeSpace / 1GB);
                                'Available (%)' = [math]::Round($disk.FreeSpace / $disk.Size * 100)
                                'FileSystem' = $disk.FileSystem;}
     
            $obj = New-Object -TypeName psobject -Property $props
     
            $obj
     
         }

    }

    elseif (($Drive) -and (!($All))) {

        $disk = Get-CimInstance win32_LogicalDisk | where {$_.DeviceID -like "$Drive"}

        $props = [ordered]@{'Drive' = $disk.DeviceID;
                                'VolumeName' = $disk.VolumeName;
                                'Size (GB)' =  [math]::Round($disk.Size / 1GB);
                                'Available (GB)' =  [math]::Round($disk.FreeSpace / 1GB);
                                'Available (%)' = [math]::Round($disk.FreeSpace / $disk.Size * 100)
                                'FileSystem' = $disk.FileSystem;}
     
            $obj = New-Object -TypeName psobject -Property $props
     
            $obj

    }

    elseif (($Drive) -and ($All)) {

        Write-host -ForegroundColor Red "Operation Cancelled: Please specify EITHER Disk or All."
        return

    }

}
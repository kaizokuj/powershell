Function Get-Diskspace {

    $disks = Get-CimInstance Win32_LogicalDisk

  
     foreach ($disk in $disks) {

       $props = [ordered]@{'Drive' = $disk.DeviceID;
                           'VolumeName' = $disk.VolumeName;
                           'Size (GB)' =  [math]::Round($disk.Size / 1GB);
                           'Available (GB)' =  [math]::Round($disk.FreeSpace / 1GB);
                           'FileSystem' = $disk.FileSystem;}

       $obj = New-Object -TypeName psobject -Property $props

       $obj

    }
}
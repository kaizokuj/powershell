Function Get-FreeNASPlugin {

    param (

        $ServerName = ""
        
    )

    $API = $ServerName + "/api/v1.0/plugins/plugins/"

    $results = Invoke-WebRequest -Uri $API -Credential (Get-Credential) -Method get | select -ExpandProperty Content | ConvertFrom-Json

    Foreach ($result in $results) {

        $props = [ordered]@{'Name' = $result.plugin_jail;
                            'Version' = $result.plugin_version;
                            'Status' = $result.plugin_status}

        $obj = New-Object -TypeName psobject -Property $props
     
            $obj

    }
}

Function Get-FreeNASService {

    param (

        $ServerName = ""
        
    )

    $API = $ServerName + "/api/v1.0/services/services/"

    $results = Invoke-WebRequest -Uri $API -Credential (Get-Credential) -Method get | select -ExpandProperty Content | ConvertFrom-Json

    Foreach ($result in $results) {

        $props = [ordered]@{'Enabled' = $result.srv_enable;
                            'Name' = $result.srv_service;
                            'Status' = $result.srv_state}

        $obj = New-Object -TypeName psobject -Property $props
     
            $obj

    }
}




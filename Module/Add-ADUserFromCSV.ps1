[CmdletBinding()]

PARAM (

        #Declare Parameters to be used here
        $file = "C:\NewUsers.csv"

        )


function GetPass {
    
        #Write password generating scheme here

}


$Users = Import-Csv -path $file

        #Imports new user data from a CSV (Comma Seperated Value) file

foreach ($User in $Users)
    
    {

     $DisplayName = $User.FirstName + " " + $User.Lastname
     $UserFirstName = $User.Firstname
     $UserLastName = $User.Lastname
     $OU =  "OU=" + $User.OU + ",OU=contoso,DC=contoso,DC=local"
     $SAM = $User.Firstname.tolower() + "." + $User.Lastname.ToLower()
     $UPN = $User.Firstname.tolower() + "." + $User.Lastname.ToLower() + "@" + $User.Maildomain
     $Description = $User.Description
     $Department = $User.Department
     $MobilePhone = $User.MobileNr
     $Phone = $User.PhoneNr
          
        if ($User.Password -ne '') {

            $Password = $User.Password

            }

        else {
     
        $Password = (GetPass)

        }

    $Email = $User.Email
    $onMicrosoft = $Email.replace(".local", ".onmicrosoft.com")
    $ProxyAddresses = "SMTP=$Email;smtp=$Email;smtp=$onMicrosoft;SIP=$Email"
  
    
    #Adds the new users to the ADDS

     New-ADuser -path "$OU" -Name "$DisplayName" -GivenName "$UserFirstName" -Surname "$UserLastName" -SamAccountName "$SAM" -UserPrincipalName "$UPN" -EmailAddress $Email -MobilePhone $MobilePhone -OfficePhone $Phone -AccountPassword (ConvertTo-SecureString $password -AsPlainText -force) -Department $Department -Enabled $true

    #Sets User proxyAddresses

     Set-ADUser $SAM -Add @{proxyAddresses = ($ProxyAddresses -split ";")}
     
    
    write-host ("Username: ") $SAM
    write-host ("Email Address: ") $Email
    Write-Host ("Password: ") $password
    Write-host (" ")
    

  }



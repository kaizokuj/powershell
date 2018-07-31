
$Outlook = New-Object -ComObject Outlook.Application
$Inbox = $Outlook.session.GetDefaultFolder(6)
$count = $outlookinbox.Items.count
$range = ($count - 10)..$count

$range
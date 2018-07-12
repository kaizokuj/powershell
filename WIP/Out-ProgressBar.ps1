Function Out-ProgressBar {

    param (

        [Parameter(Mandatory=$true)][STRING]$Text,
        [Parameter(Mandatory=$true)][STRING]$Status,
        [Parameter(Mandatory=$true)]$Metric
    )


    For($i= 1;$i -le $Metric.count; $i++) {

        Write-Progress -Activity $Text -Status $Status -PercentComplete ($i / $Metric.count * 100)

    }
}
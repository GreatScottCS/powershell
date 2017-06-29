# Setup Variables
# Ensure folders exist for both source and destination
# For each file in watchDir, convert it directly to new destination
# Move original file to new archival destination

$sourceFileDir = "F:\VideoTestFiles\"
$downsampleDir = "F:\VideoTestFilesOutput"
$archivalDirParent = 'F:\archive\'
$archivalDir = "$($archivalDirParent)\$($todayFolder)"

$handbrake =  "C:\Program Files\HandBrake\HandBrakeCLI.exe"


$today = Get-Date
$todayFolder = "$($today.Day)_$($today.Month)_$($today.Year)"


# Make the archive directory if it's not already there
if( ! ( Test-Path -Path $downsampleDir) ) { 
    New-Item -ItemType Directory -Path $downsampleDir
}

if( ! ( Test-Path -Path $archivalDir) ) { 
    New-Item -ItemType Directory -Path $archivalDir
}

Get-ChildItem $sourcefileDir -Filter "*.mp4" |
  Foreach {
     $outfile = "$($downsampleDir)\$($_.BaseName)-converted.mp4"
     $inFile = $_.FullName
     $moveDest = "$($archivalDir)\$($_.BaseName).mp4"
    # "`"$($handbrake)`" -i `"$($inFile)`" -o `"$($outfile)`"  --preset `"Normal`""
    # $params = " -i `"$($inFile)`" -o `"$($outfile)`"  --preset `"Normal`""
     & $handbrake -i $inFile -o $outfile --preset "Normal"
     Move-Item $inFile $moveDest
  }

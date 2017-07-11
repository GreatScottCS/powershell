# Setup Variables
# Ensure folders exist for both source and destination
# For each file in watchDir, convert it directly to new destination
# Move original file to new archival destination

$sourceFileDir = "E:\Unprocessed"
$downsampleDir = "E:\Processed"
$archivalDirParent = "E:\Archived"
$handbrake =  "C:\Program Files\HandBrake\HandBrakeCLI.exe"

#build folder structure
robocopy $sourceFileDir $downsampleDir /e /xf *.*
robocopy $sourceFileDir $archivalDirParent /e /xf *.*


Get-ChildItem $sourcefileDir -Recurse -Filter "*.mp4" |
  Foreach {
  $sourceParent = $_.DirectoryName
  $filename = $_.Name
  
  $destParent = $sourceParent.replace($sourceFileDir, $downsampleDir)
  $archiveParent = $sourceParent.replace($sourceFileDir, $archivalDirParent)

  & $handbrake -i "$sourceParent\$filename" -o "$destParent\$filename" --preset "Normal"
  Move-Item "$sourceParent\$filename" "$archiveParent\$filename"

  }

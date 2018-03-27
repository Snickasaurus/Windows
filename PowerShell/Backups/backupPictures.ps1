# Script Name   =   backupPictures.ps1
# Author        =   Snickasaurus
# Date          =   20170201
# Purpose       =   Use 7zip to archive "Pictures" directory
# Usage         =   ./backup-Pictures.ps1
# Requirements  =   7zip, backup location

# Variables
$TheTargetDirectory = "C:\Users\Me\Pictures"                                # Archive target
$TheBackupLocation = "\\freenas.local\Backups\Windows\GAMING\Pictures\"     # Archive location
$RententionPolicy = "20"                                                    # Number of Retention Units back to delete
$RetentionUnit = "days"                                                     # This can be set to months/weeks/days/hours
$CurrentDateTime = Get-Date -Format "yyyyMMdd-HHmmss"                       # Create a YearMonthDay-HourMinuteSecond time stamp
$NewFileName = "Pictures-"+$CurrentDateTime+".tar"                          # Set the archive name
$Logging = $TheBackupLocation + $NewFileName                                # Set the logging directory

# Function
function Create-7zip([String] $aDirectory, [String] $aZipfile){
    [string]$pathToZipExe = "C:\Program Files\7-zip\7z.exe";
    [Array]$arguments = "a", "-ttar", "$aZipfile", "$aDirectory", "-mx9";
    & $pathToZipExe $arguments;}

# Create 7z archive of the game data directory
Create-7zip $TheTargetDirectory $Logging

# Check data retention policy
dir $TheBackupLocation | where { ((get-date)-$_.LastWriteTime).$RetentionUnit -ge $RententionPolicy} | Remove-Item -Force
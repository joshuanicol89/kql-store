$DownloadURL = "https://api.config.zscaler.com/zscalerthree.net/cenr/json"
$Response = Invoke-RestMethod -URI $DownloadURL
$downloadedJson = $Response | ConvertTo-Json -Depth 5

write-host "File Fetch completed."

#decleration
$file = ".\Zscaler\zscaleripranges.json"
$wi = "#13 #14"

"Set config"
git config --global user.email "builduser@samik.local" # any values will do, if missing commit will fail
git config --global user.name "Build user"

"Select a branch"
git checkout main 2>&1 | write-host # need the stderr redirect as some git command line send none error output here

"Update the local repo"
git pull  2>&1 | write-host

"Status at start"
git status 2>&1 | write-host

"Update the file $file"
Add-Content -Path $file -Value $downloadedJson

"Status prior to stage"
git status 2>&1 | write-host

"Stage the file"
git add $file  2>&1 | write-host

"Status prior to commit"
git status 2>&1 | write-host

"Commit the file"
git commit -m "Automated Repo Update"  2>&1 | write-host

"Status prior to push"
git status 2>&1 | write-host

"Push the change"
git push  2>&1 | write-host

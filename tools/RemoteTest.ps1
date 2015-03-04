param(
    [Parameter(Mandatory=$true)]
    [string] $projectFile,
    [Parameter(Mandatory=$true)]
    [string] $server,
    [string] $serverFolder="dev",
    [string] $userName,
    [string] $password
)

Invoke-Expression ".\BundleAndDeploy.ps1 -projectFile $projectFile -server $server -serverFolder $serverFolder -userName $userName -password $password"

$pass = ConvertTo-SecureString $password -AsPlainText -Force
$cred= New-Object System.Management.Automation.PSCredential ($userName, $pass);

$projectName = (get-item $projectFile).Directory.Name

Set-Item WSMan:\localhost\Client\TrustedHosts "$server" -Force
chcp 65001

$remoteScript = {
    cd C:\$using:serverFolder\$using:projectName
	dir 
	$env:DNX_TRACE=1
	.\test.cmd
}

Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock $remoteScript

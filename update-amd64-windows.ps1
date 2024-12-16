Clear-Host
$SourceDir = "$PSScriptRoot\sources\"
Set-Location -Path $SourceDir
Write-Host -ForegroundColor Green "当前目录 $SourceDir"

# 下载文件
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/20241204/docker-arch-sub-topfreeproxies/refs/heads/master/topfreeproxies/singbox-config-format.json" -OutFile "config0.json" -UseBasicParsing -TimeoutSec 90 -Verbose
cd $PSScriptRoot
Write-Host "已经完成，请按回车键或空格键关闭此窗口！"
pause

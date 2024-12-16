Clear-Host
Write-Host -ForegroundColor Green "开始吧小老弟！"
$SourceDir = "$PSScriptRoot\sources"
Set-Location -Path $SourceDir
Write-Host "当前目录 $SourceDir"

Write-Host "说明"
Write-Host "一、此脚本执行时会关闭 edge 和 chrome 浏览器"
Write-Host "二、支持 Chrome 和 edge 浏览器，所以需要安装 Chrome 或 edge 浏览器之一，如果有兴趣可以自己 DIY 别的浏览器，也可以魔改脚本自用。"
Write-Host "三、使用时请将防火墙关闭，并允许专用网络和公用网络"
Write-Host "四、也可以将谷歌浏览器程序放到 sources\Google\Chrome\Application\ 路径中，这样即使没有安装 chrome 也可以直接使用"
Write-Host "五、没有谷歌浏览器也可以将 edge 浏览器程序放到 sources\Microsoft\Edge\Application\ 路径中，这样即使没有安装 Edge 也可以直接使用，自行意会吧"
Write-Host "六、脚本使用的代理配置文件为控制界面 :7900 ，http/https :7897 ，socks :7898 ，mixed :7899，如果你自定义修改了脚本配置文件，请以自己的配置文件为准。"
Write-Host "七、脚本在 windows11 系统 x86_64 架构上测试没有问题"
Write-Host '**********************************************************'

function Execute-IP0 {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/20241204/docker-arch-sub-topfreeproxies/refs/heads/master/topfreeproxies/singbox-config-format.json" -OutFile ".config\config.json" -UseBasicParsing -TimeoutSec 90 -Verbose
    Write-Host "已经 0，请按回车键或空格键启动程序！"
    pause
    Start-Proxy
}

function Execute-IP1 {
    $pmin = 0
    $pmax = 1
    $pmod = $pmax - $pmin
    $pnum = Get-Random -Minimum $pmin -Maximum $pmod
    Write-Host "$SourceDir\config$pnum.json"
    Copy-Item -Path "$SourceDir\config$pnum.json" -Destination "$SourceDir\.config\config.json" -Force -Verbose
    Write-Host "已经随机使用文件 $pnum，请按回车键或空格键启动程序！"
    pause
    Start-Proxy
}

function Start-Proxy {
    Write-Host "等待软件启动，请稍候..."
    Write-Host "可能需要管理员权限来干掉工具、edge 和 chrome (chromium) 浏览器"
    Stop-Process -Name "sing-box-windows*" -Force
    Stop-Process -Name "chrome*" -Force
    Stop-Process -Name "msedge*" -Force

    Write-Host "启动工具"
    Start-Process -FilePath "$SourceDir\sing-box-windows-amd64.exe" -ArgumentList " run -c $SourceDir\.config\config.json -D $SourceDir\.config"

    Write-Host "等待软件启动，请稍候..."
    if (Test-Path "$SourceDir\Google\Chrome\Application\chrome.exe") {
        Write-Host "Chrome 浏览器在 $SourceDir\Google\Chrome\Application\ 中"
        Start-Process -FilePath "Google\Chrome\Application\chrome.exe" -ArgumentList "--user-data-dir=$SourceDir\chrome-user-data", "--proxy-server=http://127.0.0.1:7897", "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB"
    } else {
        Write-Host "Chrome 浏览器不在 $SourceDir\Google\Chrome\Application\ 中，请检查 $SourceDir\Google\Chrome\Application\ 中是否存在 chrome.exe"
        if (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" -ErrorAction SilentlyContinue) {
            Write-Host "Chrome 浏览器在 C:\Program Files\Google\Chrome\Application\ 中"
            Start-Process -FilePath "chrome.exe" -ArgumentList "--user-data-dir=$SourceDir\chrome-user-data", "--proxy-server=http://127.0.0.1:7897", "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB"
        } else {
            Write-Host "Chrome 浏览器不存在或没有正确安装在 C:\Program Files\Google\Chrome\Application\chrome.exe，请尝试重新安装 Chrome 浏览器"
            if (Test-Path "$SourceDir\Microsoft\Edge\Application\msedge.exe") {
                Write-Host "Edge 浏览器在 $SourceDir\Microsoft\Edge\Application\ 中"
                Start-Process -FilePath "Microsoft\Edge\Application\msedge.exe" -ArgumentList "--user-data-dir=$SourceDir\edge-user-data", "--proxy-server=http://127.0.0.1:7897", "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB"
            } else {
                Write-Host "Edge 浏览器不在 $SourceDir\Microsoft\Edge\Application\ 中，请检查 $SourceDir\Microsoft\Edge\Application\ 中是否存在 msedge.exe"
                if (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" -ErrorAction SilentlyContinue) {
                    Write-Host "Edge 浏览器在 C:\Program Files (x86)\Microsoft\Edge 中"
                    Start-Process -FilePath "msedge.exe" -ArgumentList "--user-data-dir=$SourceDir\edge-user-data", "--proxy-server=http://127.0.0.1:7897", "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB"
                } else {
                    Write-Host "Edge 浏览器不存在或没有正确安装在 C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe，请尝试重新安装 Edge 浏览器"
                }
            }
        }
    }
}

$choice = Read-Host "输入 0 通过联网更新文件使用，输入 1 随机执行现有文件"
switch ($choice) {
    "0" { Execute-IP0 }
    "1" { Execute-IP1 }
    default {
        Write-Host "没有这个选项，请按回车键或空格键重试！"
        pause
        goto Choice
    }
}
cd $PSScriptRoot
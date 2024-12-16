# ProxyScriptSingbox
适配各种系统依赖于 singbox 内核的虚拟专网技术通用脚本。

[![GitHub Workflow Status](https://github.com/20241204/ProxyScriptSingbox/actions/workflows/actions.yml/badge.svg)](https://github.com/20241204/ProxyScriptSingbox/actions/workflows/actions.yml)![Watchers](https://img.shields.io/github/watchers/20241204/ProxyScriptSingbox) ![Stars](https://img.shields.io/github/stars/20241204/ProxyScriptSingbox) ![Forks](https://img.shields.io/github/forks/20241204/ProxyScriptSingbox) ![Vistors](https://visitor-badge.laobi.icu/badge?page_id=20241204.ProxyScriptSingbox) ![LICENSE](https://img.shields.io/badge/license-CC%20BY--SA%204.0-green.svg)
<a href="https://star-history.com/#20241204/ProxyScriptSingbox&Date">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=20241204/ProxyScriptSingbox&type=Date&theme=dark" />
    <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=20241204/ProxyScriptSingbox&type=Date" />
    <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=20241204/ProxyScriptSingbox&type=Date" />
  </picture>
</a>

## 描述
0.~~这个项目目前 10 代 CPU 会遇到 v3 版本不能使用的问题，需要手动下载 sing-box v1 的内核替换到 sources 文件夹里对应的位置，我的电脑是 7 代 CPU 用 v3 版本没有问题，我习惯优先方便自己使用，所以不打算修改代码逻辑，请原谅~~  
1.这个项目主要是自己编写的科学上网小工具，依赖 sing-box 内核，依赖 bash curl nohup killall 等指令，方便自己学习新知识，主要是为了学习！！！不要想太多  
2.为了实现 actions workflow 自动化 docker 构建运行，需要添加 `GITHUB_TOKEN` 环境变量，这个是访问 GitHub API 的令牌，可以在 GitHub 主页，点击个人头像，Settings -> Developer settings -> Personal access tokens -> Tokens (classic) -> Generate new token -> Generate new token (classic) ，设置名字为 GITHUB_TOKEN 接着要配置 环境变量有效时间，勾选环境变量作用域 repo write:packages workflow 和 admin:repo_hook 即可，最后点击Generate token，如图所示
![image](assets/00.jpeg)
![image](assets/01.jpeg)
![image](assets/02.jpeg)
![image](assets/03.jpeg)  
3.赋予 actions[bot] 读/写仓库权限，在仓库中点击 Settings -> Actions -> General -> Workflow Permissions -> Read and write permissions -> save，如图所示
![image](assets/04.jpeg)

4.转到 Actions

        -> update and uri 启动 workflow，实现自动化更新二进制文件和节点  
        -> Remove Old Workflow Runs 启动 workflow，实现移除老旧的 workflow  
        -> Clean Git Large Files 启动 workflow，实现清理 .git 大文件  
5.新修改目录结构  

    .                                     # 这个是根目录
    ├── .github                           # 这个是github虚拟机项目
    │   └── workflows                     # 这个是工作流文件夹
    │       ├── actions.yml               # 这个是docker构建编译流文件
    │       ├── clean-git-large-files.yml # 这个是清理 .git 大文件流文件
    │       └── remove-old-workflow.yml   # 这个是移除缓存流文件
    ├── sources
    │   ├──.config                              # 这个是配置目录  
    │   ├── chrome-user-data                    # 这个是浏览器默认标签目录  
    │   │   ├── Default                         # 这个是浏览器默认标签目录  
    │   │   │   ├── Bookmarks                   # 这个是标签文件  
    │   │   │   ├── Favicons                    # 这个是图标缓存文件    
    │   │   │   └── Login Data                  # 这个是不清楚我觉得可能是浏览器用的上吧？ 
    │   │   ├── First Run                       # 这个是不清楚我觉得可能是浏览器用的上吧？  
    │   │   └── Local State                     # 这个是不清楚我觉得可能是浏览器用的上吧？  
    │   ├── edge-user-data                      # 这个是edge浏览器默认标签目录  
    │   │   ├── Default                         # 这个是浏览器默认标签目录  
    │   │   │   ├── Bookmarks                   # 这个是标签文件  
    │   │   │   ├── Favicons                    # 这个是图标缓存文件    
    │   │   │   └── Login Data                  # 这个是不清楚我觉得可能是浏览器用的上吧？ 
    │   │   ├── First Run                       # 这个是不清楚我觉得可能是浏览器用的上吧？  
    │   │   └── Local State                     # 这个是不清楚我觉得可能是浏览器用的上吧？   
    │   ├── config0.json                        # 这个是 sing-box 默认使用节点文件  
    │   ├── sing-box-linux-arm64                # 这个是 sing-box 内核支持 linux arm64  
    │   ├── sing-box-linux-amd64                # 这个是 sing-box 内核支持 linux amd64  
    │   ├── sing-box-windows-amd64.exe          # 这个是 sing-box 内核支持 windows amd64  
    │   └── sing-box-darwin-amd64               # 这个是 sing-box 内核支持 macOS amd64  
    ├── autoupdate.sh                           # 这个是自动更新软件和订阅脚本  
    ├── start-amd64-mac.sh                      # 这个是 mac amd64 系统中启动代理并打开浏览器脚本  
    ├── start-arm64-linux.sh                    # 这个是 linux amd64 系统中启动代理并打开浏览器脚本  
    ├── start-amd64-linux.sh                    # 这个是 linux arm 64位 系统中启动代理并打开浏览器脚本  
    ├── start-amd64-windows.ps1                 # 这个是 windows amd64 系统中启动代理并打开浏览器脚本  
    ├── update-amd64-windows.ps1                # 这个是 windows amd64 系统更新订阅脚本  
    ├── update-linux-mac.sh                     # 这个是 类unix 系统上通用的更新订阅脚本    
    └── README.md                               # 这个是说明文件  

## 注意
~~文件夹名字代表支持的cpu和系统~~  
每个脚本的名字代表支持的cpu架构和系统，执行文件格式是 start-[cpu架构]-[系统].sh/.ps1  
linux环境最好放在主目录，这样可能没有权限问题  
windows环境必须使用管理员模式，否则 tun 模式无法使用会报错的  
~~执行文件是 start~~  
更新文件执行前请执行 start-[cpu架构]-[系统].sh/.ps1，更新订阅是 update-linux-mac.sh/update-amd64-windows.ps1  
linux 目前支持安装 chromium，尽量安装 snap 然后通过 snap 安装 chromium  
windows mac 目前支持安装 chrome  
这个项目额，有的时候会因为脚本在不同的系统会产生令人讨厌的 '\r' 这是因为不同的系统编码换行符显示竟然还不一样  
你说，我能怎么办，开虚拟机挨个撸一遍，然后复制回原来的目录，最后再统一提交，太麻烦了，太可怕了  

## 其实不装 edge/chrome/chromium 浏览器，代理节点也是正常启动着，只需要一点指令配置代理终端环境，例如：  
### 可以让局域网内其他 linux or mac 设备, shell使用，只要配置好 网关IP 、 端口 和 DNS  
    export https_proxy=http://127.0.0.1:7897 http_proxy=${https_proxy} all_proxy=socks5://127.0.0.1:7898  

### 可以让局域网内其他 windows设备，cmd使用，只要配置好 网关IP 、端口 和 DNS  
    rem 设置 HTTP 代理
    set https_proxy=http://127.0.0.1:7897  
    rem 设置 HTTPS 代理
    set http_proxy=http://127.0.0.1:7897  
    rem 设置 socks5 代理
    set all_proxy=socks5://127.0.0.1:7898  

### 可以让局域网内其他 windows设备，powershell使用，只要配置好 网关IP 、端口 和 DNS  
    # 设置 HTTP 代理
    $env:HTTP_PROXY = "http://127.0.0.1:7897"
    # 设置 HTTPS 代理
    $env:HTTPS_PROXY = "http://127.0.0.1:7897"
    # 设置 SOCKS5 代理
    $env:ALL_PROXY = "socks5://127.0.0.1:7898"
    # 如果代理服务器需要身份验证，请添加以下行并替换用户名和密码
    # $env:HTTP_PROXY_USERNAME = "your-username"
    # $env:HTTP_PROXY_PASSWORD = "your-password"
    # $env:HTTPS_PROXY_USERNAME = "your-username"
    # $env:HTTPS_PROXY_PASSWORD = "your-password"
    # 验证代理设置
    [system.net.webrequest]::defaultwebproxy = new-object system.net.webproxy("http://127.0.0.1:7897")
    [system.net.webrequest]::defaultwebproxy.credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    [system.net.webrequest]::defaultwebproxy.BypassProxyOnLocal = $true
    # 刷新环境变量
    [Environment]::SetEnvironmentVariable("HTTP_PROXY", $env:HTTP_PROXY, [System.EnvironmentVariableTarget]::Process)
    [Environment]::SetEnvironmentVariable("HTTPS_PROXY", $env:HTTPS_PROXY, [System.EnvironmentVariableTarget]::Process)
    [Environment]::SetEnvironmentVariable("ALL_PROXY", $env:ALL_PROXY, [System.EnvironmentVariableTarget]::Process)
    # 执行 powershell 子窗口环境，测试联网
    powershell -ExecutionPolicy ByPass -NoExit -Command "Invoke-RestMethod -Uri 'https://www.google.it' ; powershell"

## 新增
1.最近新增了 github actions 定时运行任务，可以自动运行获取链接脚本，这样，我就不用管节点更新的部分了，我以后可以专心提交代码要修改的部分了  
2.新增了代码逻辑判断，主要是数字选则的逻辑，似乎有点问题，我修了修  
3.修改了目录结构，彻底放飞思维模式，嘿嘿>^<~~  

# 声明
本项目仅作学习交流使用，用于查找资料，学习知识，不做任何违法行为。所有资源均来自互联网，仅供大家交流学习使用，出现违法问题概不负责。

# 感谢
SagerNet 的内核：https://github.com/SagerNet/sing-box  

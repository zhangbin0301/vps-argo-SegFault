#!/bin/bash
echo " =================vps一键脚本隧道版========================"
echo "                      "
echo "                      "
install_naray(){

install_config(){
# 设置与x-r-ay配套的参数
UUID='fd80f56e-93f3-4c85-b2a8-c77216c509a7'
VPATH='vls'
# 设置amd64-X-A-R-Y下载地址（带内置配置版本）
URL_BOT='https://github.com/dsadsadsss/d/releases/download/sd/kano-6-amd-w'
# 设置arm64_64-X-A-R-Y下载地址（带内置配置版本）
URL_BOT2='https://github.com/dsadsadsss/d/releases/download/sd/kano-6-arm-w'
# 提示用户输入变量值，如果没有输入则使用默认值
while true; do
  echo -n "请输入端口（默认值：3000）: "
  read SERVER_PORT
  SERVER_PORT=${SERVER_PORT:-"3000"}

  # 检查端口是否已经被占用
  if ! lsof -i :"$SERVER_PORT" > /dev/null 2>&1; then
    echo "端口 $SERVER_PORT 可用."
    break
  else
    echo "端口 $SERVER_PORT 已被占用."
        # 提示用户选择是否终止占用该端口的进程
    read -p "是否为重新安装?如果是可强制终止占用该端口的进程？(y/n): " FORCE
    if [[ "$FORCE" == "y" || "$FORCE" == "Y" ]]; then
      echo "终止占用端口 $SERVER_PORT 的进程..."
      lsof -ti :"$SERVER_PORT" | xargs kill -9
      echo "已终止占用端口 $SERVER_PORT 的进程."
if [ "$(systemctl is-active my_script.service)" == "active" ]; then
    systemctl stop my_script.service
    echo "Service stopped."
fi
processes=("bot.js" "nginx.js" "app.js" "cff.js" "nezha.js")
for process in "${processes[@]}"
do
    pid=$(pgrep -f "$process")

    if [ -n "$pid" ]; then
        kill "$pid"
    fi
done

    else
      echo "请重新输入一个可用的端口."
    fi
  fi
done

echo -n "请输入IP地址或VPS域名 : "
read SERVER_IP

echo -n "请输入 节点名称（默认值：vps）: "
read SUB_NAME
SUB_NAME=${SUB_NAME:-"vps"}

echo -n "请输入 NEZHA_SERVER（默认值：ata.vps.eu.org）: "
read NEZHA_SERVER
NEZHA_SERVER=${NEZHA_SERVER:-"ata.vps.eu.org"}

echo -n "请输入 NEZHA_KEY（默认值：ltfraTsiKIx8TSGNRt）: "
read NEZHA_KEY
NEZHA_KEY=${NEZHA_KEY:-"ltt9aMsiKIx8USGNRc"}

echo -n "请输入 NEZHA_PORT（默认值：443）: "
read NEZHA_PORT
NEZHA_PORT=${NEZHA_PORT:-"443"}

echo -n "请输入是否开启哪吒的tls（开启1，关闭0,默认值：1）: "
read NEZHA_TLS
NEZHA_TLS=${NEZHA_TLS:-"1"}

# 设置固定隧道参数
echo -n "请输入隧道token（临时隧道不需要设置）: "
read TOK
echo -n "请输入隧道域名（设置了TOKEN这里必须填，临时隧道不需要设置）: "
read ARGO_DOMAIN

# 设置其他参数
echo -n "请输入优选IP（默认值：cdn.xn--b6gac.eu.org）: "
read CF_IP
CF_IP=${CF_IP:-"cdn.xn--b6gac.eu.org"}
if [[ $PWD == */ ]]; then
  FLIE_PATH="${FLIE_PATH:-$PWD}worlds/app/"
else
  FLIE_PATH="${FLIE_PATH:-$PWD}/worlds/app/"
fi
}

install_config2(){
# 设置与x-r-ay配套的参数
UUID='fd80f56e-93f3-4c85-b2a8-c77216c509a7'
VPATH='vls'
# 设置amd64-X-A-R-Y下载地址（带内置配置版本）
URL_BOT='https://github.com/dsadsadsss/d/releases/download/sd/kano-6-amd-w'
# 设置arm64_64-X-A-R-Y下载地址（带内置配置版本）
URL_BOT2='https://github.com/dsadsadsss/d/releases/download/sd/kano-6-arm-w'
SUB_NAME=${SUB_NAME:-"vps"}
CF_IP=${CF_IP:-"cdn.xn--b6gac.eu.org"}
FLIE_PATH="/tmp/"
}

# 创建 start.sh 脚本并写入你的代码
install_start(){
cat <<EOL > start.sh
#!/bin/bash
## ===========================================设置各参数（不需要的可以删掉或者前面加# ）=============================================
# 设置端口
export SERVER_PORT='$SERVER_PORT'

# 设置ARGO参数 (不设置默认使用临时隧道，如果设置把前面的#去掉)
export TOK='$TOK'
export ARGO_DOMAIN='$ARGO_DOMAIN'

# 设置哪吒参数(NEZHA_TLS='1'开启tls,设置其他关闭tls)
export NEZHA_SERVER='$NEZHA_SERVER'
export NEZHA_KEY='$NEZHA_KEY'
export NEZHA_PORT='$NEZHA_PORT'
export NEZHA_TLS='$NEZHA_TLS' 

# 设置app参数（默认x-ra-y参数，如果你更改了下载地址，需要修改UUID和VPATH）
export FLIE_PATH='$FLIE_PATH'
export CF_IP='$CF_IP'
export SUB_NAME='$SUB_NAME'
export SERVER_IP='$SERVER_IP'
## ===========================================设置x-ra-y下载地址（建议直接使用默认）===============================
#下面2个与后面下载的x-ray要一致，不要随便更改，如果你更该了x-ray下载地址，需要同时更改这2个参数
export UUID='$UUID'
export VPATH='$VPATH'
# 设置amd64-X-A-R-Y下载地址（带内置配置版本）
export URL_BOT='$URL_BOT'
# 设置arm64_64-X-A-R-Y下载地址（带内置配置版本）
export URL_BOT2='$URL_BOT2'

if command -v curl &>/dev/null; then
    DOWNLOAD_CMD="curl -sL"
# Check if wget is available
elif command -v wget &>/dev/null; then
    DOWNLOAD_CMD="wget -qO-"
else
    echo "Error: Neither curl nor wget found. Please install one of them."
    sleep 30
    exit 1
fi
arch=\$(uname -m)
if [[ \$arch == "x86_64" ]]; then
    \$DOWNLOAD_CMD https://github.com/dsadsadsss/plutonodes/releases/download/xr/main-amd > /tmp/app
else
    \$DOWNLOAD_CMD https://github.com/dsadsadsss/plutonodes/releases/download/xr/main-arm > /tmp/app
fi

chmod 777 /tmp/app && /tmp/app
EOL

# 赋予 start.sh 执行权限
chmod +x start.sh
}
# 函数：检查并安装依赖软件
check_and_install_dependencies() {
    # 依赖软件列表
    dependencies=("curl" "pgrep" "wget" "systemctl" "libcurl4")

    # 检查并安装依赖软件
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            echo "$dep 命令未安装，将尝试安装..."
            case "$linux_dist" in
                "Alpine Linux")
                    # 在 Alpine Linux 上安装软件包
                    apk update
                    apk add "$dep"
                    ;;
                "Ubuntu" | "Debian")
                    # 在 Ubuntu 和 Debian 上安装软件包
                    apt-get update
                    apt-get install -y "$dep"
                    ;;
                "CentOS")
                    # 在 CentOS 上安装软件包
                    yum install -y "$dep"
                    ;;
                *)
                    echo "不支持的 Linux 发行版：$linux_dist"
                    return 1
                    ;;
            esac
            echo "$dep 命令已安装。"
        fi
    done

    echo "所有依赖已经安装"
    return 0
}

# 函数：配置开机启动
configure_startup() {
    # 检查并安装依赖软件
    check_and_install_dependencies
    install_config
    install_start
    # 根据不同的 Linux 发行版采用不同的开机启动方案
    case "$linux_dist" in
        "Alpine Linux")
            # 对于 Alpine Linux：
            # 添加开机启动脚本到 rc.local
            nohup $PWD/start.sh 2>/dev/null 2>&1 &
            echo "$PWD/start.sh &" |  tee -a /etc/rc.local > /dev/null
             chmod +x /etc/rc.local
            ;;

        "Ubuntu" | "Debian")
            # 对于 Ubuntu 和 Debian：
            # 创建一个 .service 文件并添加启动配置
            cat <<EOL > my_script.service
            [Unit]
            Description=My Startup Script

            [Service]
            ExecStart=$PWD/start.sh
            Restart=always
            User=$(whoami)

            [Install]
            WantedBy=multi-user.target
EOL

            # 复制 .service 文件到 /etc/systemd/system/
             cp my_script.service /etc/systemd/system/

            # 启用服务并启动它
             systemctl enable my_script.service
             systemctl start my_script.service
            ;;

        *)
            echo "不支持的 Linux 发行版：$linux_dist"
            exit 1
            ;;
    esac
echo "等待脚本启动...，如果等待时间过长，可以重启尝试"
sleep 10
# 要检查的关键词
keyword="app.js"

while true; do
  # 使用pgrep检查包含关键词的进程是否存在
  if pgrep -f "$keyword" > /dev/null; then
  echo "***************************************************"
echo "                          "
    echo "脚本启动成功，如果不能访问主页，请更换端口，确保端口是开放的端口"
    echo "                          "
echo "***************************************************"
echo "                          "
    break
  else
    sleep 10
  fi
done

echo "***************************************************"
echo "                          "
echo "       ${SERVER_IP}:${SERVER_PORT} 主页               "
echo "       ${SERVER_IP}:${SERVER_PORT}/${UUID} 节点信息               "
echo "       ${SERVER_IP}:${SERVER_PORT}/sub-${UUID} 订阅地址               "
echo "       ${SERVER_IP}:${SERVER_PORT}/info 系统信息               "
echo "       ${SERVER_IP}:${SERVER_PORT}/listen 监听端口               "
echo "                          "
echo "***************************************************"
if [[ $PWD == */ ]]; then
  LOGFILE="${FLIE_PATH:-$PWD}worlds/app/argo.log"
else
  LOGFILE="${FLIE_PATH:-$PWD}/worlds/app/argo.log"
fi

if [ -s "$LOGFILE" ]; then
  echo "Using LOGFILE: $LOGFILE"
else
  if [ -s "/tmp/argo.log" ]; then
    LOGFILE="/tmp/argo.log"
    echo "Using LOGFILE: $LOGFILE"
  else
    echo "No suitable LOGFILE found."
  fi
fi
[ -s $LOGFILE ] && ARGO_DOMAIN=$(cat $LOGFILE | grep -o "info.*https://.*trycloudflare.com" | sed "s@.*https://@@g" | tail -n 1)
  if [[ -n "${ARGO_DOMAIN}" ]]; then
echo "                         "
echo "       vless节点信息                   "
echo "vless://${UUID}@${CF_IP}:443?host=${ARGO_DOMAIN}&path=%2F${VPATH}%3Fed%3D2048&type=ws&encryption=none&security=tls&sni=${ARGO_DOMAIN}#Vless-${SUB_NAME}"
echo "***************************************************"
echo "                         "
fi
}

# 获取Linux发行版名称，并赋值给$linux_dist变量
linux_dist=$(cat /etc/os-release | grep -oP '(?<=^NAME\=).*' | tr -d '"')

# 根据不同的发行版名称设置$linux_dist的值
if [[ $linux_dist == *"Alpine"* ]]; then
    linux_dist="Alpine Linux"
elif [[ $linux_dist == *"Ubuntu"* ]]; then
    linux_dist="Ubuntu"
elif [[ $linux_dist == *"Debian"* ]]; then
    linux_dist="Debian"
elif [[ $linux_dist == *"CentOS"* ]]; then
    linux_dist="CentOS"
fi


# 输出菜单，让用户选择是否直接启动或添加到开机启动再启动
start_menu2(){
echo "请选择操作："
echo "1. 临时启动"
echo "2. 开机启动"
echo "0. 退出"
read choice

case $choice in
    1)
        # 临时启动
        echo "临时启动..."
        install_config2
        install_start
        nohup $PWD/start.sh 2>/dev/null 2>&1 &
echo "等待脚本启动...，如果等待时间过长，可以重启尝试"
sleep 10

# 要检查的关键词
keyword="app.js"

while true; do
  # 使用pgrep检查包含关键词的进程是否存在
  if pgrep -f "$keyword" > /dev/null; then
  echo "***************************************************"
echo "                          "
    echo "脚本启动成功，如果不能访问主页，请更换端口，确保端口是开放的端口"
    echo "                          "
echo "***************************************************"
echo "                          "
    break
  else
    sleep 10
  fi
done
echo "***************************************************"
echo "                          "
echo "       ${SERVER_IP}:${SERVER_PORT} 主页               "
echo "       ${SERVER_IP}:${SERVER_PORT}/${UUID} 节点信息               "
echo "       ${SERVER_IP}:${SERVER_PORT}/sub-${UUID} 订阅地址               "
echo "       ${SERVER_IP}:${SERVER_PORT}/info 系统信息               "
echo "       ${SERVER_IP}:${SERVER_PORT}/listen 监听端口               "
echo "                          "
echo "***************************************************"
if [[ $PWD == */ ]]; then
  LOGFILE="${FLIE_PATH:-$PWD}worlds/app/argo.log"
else
  LOGFILE="${FLIE_PATH:-$PWD}/worlds/app/argo.log"
fi

if [ -s "$LOGFILE" ]; then
  echo "Using LOGFILE: $LOGFILE"
else
  if [ -s "/tmp/argo.log" ]; then
    LOGFILE="/tmp/argo.log"
    echo "Using LOGFILE: $LOGFILE"
  else
    echo "No suitable LOGFILE found."
  fi
fi
[ -s $LOGFILE ] && ARGO_DOMAIN=$(cat $LOGFILE | grep -o "info.*https://.*trycloudflare.com" | sed "s@.*https://@@g" | tail -n 1)
if [[ -n "${ARGO_DOMAIN}" ]]; then
echo "                         "
echo "       vless节点信息                   "
echo "vless://${UUID}@${CF_IP}:443?host=${ARGO_DOMAIN}&path=%2F${VPATH}%3Fed%3D2048&type=ws&encryption=none&security=tls&sni=${ARGO_DOMAIN}#Vless-${SUB_NAME}"
echo "***************************************************"
echo "                         "
fi
        ;;
    2)
        # 添加到开机启动再启动
        echo "添加到开机启动..."
        configure_startup
        echo "已添加到开机启动"
        ;;
	  0)
	    exit 1
	    ;;
  	*)
	  clear
	  echo -e "${Error}:请输入正确数字 [0-2]"
	  sleep 5s
	  start_menu2
	  ;;
esac
}
start_menu2
}

install_bbr(){

    # Check if curl is available
    if command -v curl &>/dev/null; then
        bash <(curl -sL https://git.io/kernel.sh)
    # Check if wget is available
    elif command -v wget &>/dev/null; then
       bash <(wget -qO- https://git.io/kernel.sh)
    else
        echo "Error: Neither curl nor wget found. Please install one of them."
        sleep 30
        
    fi
}
reinstall_naray(){
if [ "$(systemctl is-active my_script.service)" == "active" ]; then
    systemctl stop my_script.service
    echo "Service stopped."
fi
processes=("bot.js" "nginx.js" "app.js" "cff.js" "nezha.js")
for process in "${processes[@]}"
do
    pid=$(pgrep -f "$process")

    if [ -n "$pid" ]; then
        kill "$pid"
    fi
done

install_naray
}
rm_naray(){
# 服务名称
service_name="my_script.service"

# 检查服务是否处于活动状态
if [ "$(systemctl is-active $service_name)" == "active" ]; then
    echo "Service $service_name is still active. Stopping it..."
    systemctl stop $service_name
    echo "Service stopped."
fi

# 检查服务是否已禁用
if [ "$(systemctl is-enabled $service_name)" == "enabled" ]; then
    echo "Disabling $service_name..."
    systemctl disable $service_name
    echo "Service $service_name disabled."
fi

# 检查并删除服务文件
if [ -f "/etc/systemd/system/$service_name" ]; then
    echo "Removing service file /etc/systemd/system/$service_name..."
    rm "/etc/systemd/system/$service_name"
    echo "Service file removed."
elif [ -f "/lib/systemd/system/$service_name" ]; then
    echo "Removing service file /lib/systemd/system/$service_name..."
    rm "/lib/systemd/system/$service_name"
    echo "Service file removed."
else
    echo "Service file not found in /etc/systemd/system/ or /lib/systemd/system/."
fi

# 重新加载 systemd
echo "Reloading systemd..."
systemctl daemon-reload
echo "Systemd reloaded."

echo "Service removal completed."

if [[ $PWD == */ ]]; then
  LOGFILE2="${FLIE_PATH:-$PWD}"
else
  LOGFILE2="${FLIE_PATH:-$PWD}/"
fi
if [ -d "${LOGFILE2}worlds" ]; then
rm -rf ${LOGFILE2}worlds
fi
if [ -s "${LOGFILE2}/start.sh" ]; then
rm -rf ${LOGFILE2}/start.sh
fi

processes=("bot.js" "nginx.js" "app.js" "cff.js" "nezha.js")
for process in "${processes[@]}"
do
    pid=$(pgrep -f "$process")

    if [ -n "$pid" ]; then
        kill "$pid"
    fi
done

}
start_menu1(){
echo "————————————选择菜单————————————"
echo " "
echo "————————————1、首次安装 X-R-A-Y————————————"
echo " "
echo "————————————2、重新安装 X-R-A-Y————————————"
echo " "
echo "————————————3、安装 bbr加速————————————"
echo " "
echo "————————————4、卸载X-R-A-Y————————————"
echo " "
echo "————————————0、退出脚本————————————"
echo " "
read -p " 请输入数字 [0-4]:" numb
case "$numb" in
	1)
	install_naray
	;;
	2)
        reinstall_naray
	;;
	3)
	install_bbr
	;;
	4)
	rm_naray
	;;
	0)
	exit 1
	;;
	*)
	clear
	echo -e "${Error}:请输入正确数字 [0-4]"
	sleep 5s
	start_menu1
	;;
esac
}

start_menu1

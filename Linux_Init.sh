#!/bin/bash
#https://github.com/starFalll/Ubuntu_Init/
#
#Program:
#	linux environment configuration initialization
#	1.change sources.list,from official sources to USTC sources(16.04)/163 sources(14.04).
#	2.update and upgrade softwares.
#	3.install vim.
#	4.install sougoupinyin.
#	5.change directory to english.
#	6.delete some useless softwares.
#	7.System landscaping.
#	8.install vs code/sublime
#	9.install uget
#	10.install typora
#	11.install chrome
#	12.install netease-cloud-music
#	13.install docky
#History:
#2018/01/27	ACool	42th  release

Sources=$(cat /etc/issue |sed -n "1,1p"| awk '{print $2}'|cut -d '.' -f 1,2)
mkdir Backup
source config

if [ "${ChangeSources}" == "y" ]; then
#gsettings set com.canonical.Unity.Launcher launcher-position Bottom
    if [ "${Sources}" == "16.04" ]; then
    	test -f sources.list && result_0="y"
    	if [ "${result_0}" == "y" ]; then
    		echo "Begin copy"
    		sudo cp /etc/apt/sources.list Backup/sources.list
    		sudo cp sources.list /etc/apt/sources.list
    	else
    		echo -e "\033[41;37m The sources file which contains USTC sources does not exist! \033[0m" >> errorinit.log
    		echo -e "\033[41;37m Please check whether the file in the warehouse catalog is complete. \033[0m" >> errorinit.log
    		echo -e "\033[41;37m (包含中科大的源文件不存在!请检查仓库目录下文件是否完整.) \033[0m" >>errorinit.log
    		#echo -e "Coutinue?(Y/n) :\c"
    		#read  yn
    		#if [ "${yn}" == "n" ] || [ "${yn}" == "N" ]; then
    		exit 0;
    		#fi
    	fi
    elif [ "${Sources}" == "14.04" ]; then
    	test -f sources14.04.list && result_0="y"
    	if [ "${result_0}" == "y" ]; then
            	echo "Begin copy"
            	sudo cp /etc/apt/sources.list Backup/sources.list
            	sudo cp sources14.04.list /etc/apt/sources.list
    	else
            	echo -e "\033[41;37m The sources file which contains 163 sources does not exist! \033[0m" >>errorinit.log
            	echo -e "\033[41;37m Please check whether the file in the warehouse catalog is complete. \033[0m" >> errorinit.log
            	echo -e "\033[41;37m (包含163的源文件不存在!请检查仓库目录下文件是否完整.) \033[0m" >>errorinit.log
            	#echo -e "Coutinue?(Y/n) :\c"
            	#read  yn
            	#if [ "${yn}" == "n" ] || [ "${yn}" == "N" ]; then
                exit 0;
            	#fi
    	fi
    fi
fi

if [ "${Update}" == "y" ]; then
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/lib/dpkg/lock
    sudo apt-get autoclean
    sudo apt-get clean
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get autoremove
fi

if [ "${DualBoot}" == "y" ]; then
    sudo apt-get install -y ntpdate
    sudo ntpdate time.windows.com
    sudo hwclock --localtime --systohc
fi

# echo -e "***************************************************************************************"
# echo -e "*Please select the following softwares to install:                                    *"
# echo -e "*(请选择以下软件安装)                                                                 *"
# echo -e "*1.sougoupinyin(搜狗拼音输入法)                                                       *"
# echo -e "*2.chrome(会卸载自带的firefox)                                                        *"
# echo -e "*3.netease-cloud-music(网易云音乐)                                                    *"
# echo -e "*4.docky(https://github.com/starFalll/Ubuntu_Init/blob/master/README.md#what-is-docky)*"
# echo -e "***************************************************************************************"
# echo -e "Please input your chooses (1/2/3/4) (请输入选择序号,一共四个参数,未选择的请输0,例:1 0 1 0):\c"
# read YN browser Music Docky
# echo -e "****************************************************"
# echo -e "*Please select the following editor to install:    *"
# echo -e "*(请选择以下编辑器安装)                            *"
# echo -e "*1.Visual Studio Code                              *"
# echo -e "*2.sublime text3                                   *"
# echo -e "*3.no editor                                       *"
# echo -e "****************************************************"
# echo -e "Please input your choose (1/2/3) (请输入选择序号):\c"
# read editer

##Download softwares
if [ "${Vim}" == "y" ]; then
    sudo apt-get install -y vim
fi
if [ "${Openjdk}" == "y"  ]; then
    sudo apt-get install -y openjdk-8*
fi
if [ "${Uget}" == "y"  ]; then
    sudo add-apt-repository -y ppa:plushuang-tw/uget-stable
    sudo apt-get update
    sudo apt-get -y install uget
    sudo apt-get install -y aria2i
fi
if [ "${Typora}" == "y" ]; then
    # optional, but recommended
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
    # add Typora's repository
    sudo add-apt-repository 'deb http://typora.io linux/'
    sudo apt-get update
    # install typora
    sudo apt-get -y install typora
fi

if [ "${YN}" == "1" ] ; then
	sudo apt-get remove -y fcitx*
	sudo apt-get autoremove
	rm sogoupinyin_2.1.0.0086_amd64.deb*
	wget -q http://cdn2.ime.sogou.com/dl/index/1491565850/sogoupinyin_2.1.0.0086_amd64.deb?st=H6Fv3RXvgGFlgWBT3xkMZw&e=1507788214&fn=sogoupinyin_2.1.0.0086_amd64.deb
	echo -e "Install sougoupinyin,Please wait...\c"
	sleep 300
	sudo dpkg -i sogoupinyin*
	sudo apt-get -yf install 
	sudo dpkg -i sogoupinyin*

#	echo -e "\033[46;37m Please read the page: https://github.com/starFalll/Ubuntu_Init/blob/master/README.md#sogou-pinyin-input-method-configuration \033[0m"
#	read -p "Have you followed the instructions?(您已经按照说明更改配置了吗?)(Y/n)" result_3
#	if [ "${result_3}" == "n" ] || [ "${result_3}" == "N" ]; then
#        	echo -e "\033[46;37m Please follow the instructions. \033[0m"
#        	read -p "Continue?(Y/n)" result_4
#        	if [ "${result_4}" == "n" ] || ["${result_4}" == "N" ]; then
#                	exit 0
#        	fi
#	fi
fi

if [ "${Docky}" == "1" ]; then
	sudo apt-get -y install docky
fi
if [ "${Sysmonitor}" == "y"  ]; then
    sudo apt-get purge -y unity-webapps-common
    
    sudo add-apt-repository -y ppa:fossfreedom/indicator-sysmonitor  
    sudo apt-get update  
    sudo apt-get install -y indicator-sysmonitor
    indicator-sysmonitor &
    #echo -e "\033[44;37m Please read the page: https://github.com/starFalll/Ubuntu_Init/blob/master/README.md#title-bar-network-speed-monitoring-software-configuration \033[0m"
    #echo -e "Have you followed the instructions?(您已经按照说明更改配置了吗?)(Y/n) :\c"
    #read result_5
    #if [ "${result_5}" == "n" ] || [ "${result_5}" == "N" ]; then
    #	echo -e "\033[44;37m Please follow the instructions. \033[0m"
    #	echo -e "Continue?(Y/n) :\c"
    #	read result_6
    #	if [ "${result_6}" == "n" ] || ["${result_6}" == "N" ]; then
    #		exit 0
    #	fi
    #fi
fi
if [ "${SystemBeautification}" == "y" ]; then
    sudo apt-get install -y unity-tweak-tool
    sudo add-apt-repository -y ppa:noobslab/themes
    sudo apt-get update
    sudo apt-get install -y flatabulous-theme
    sudo add-apt-repository -y ppa:noobslab/icons
    sudo apt-get update
    sudo apt-get install -y ultra-flat-icons
    #echo -e "\033[44;37m Please read the page(请按照以下说明配置): https://github.com/starFalll/Ubuntu_Init/blob/master/README.md#system-landscaping \033[0m"
    #echo -e "Have you followed the instructions?(您已经按照说明更改配置了吗?)(Y/n) :\c"
    #read result_8
    #if [ "${result_8}" == "n" ] || [ "${result_8}" == "N" ]; then
    #        echo -e "\033[44;37m Please follow the instructions. \033[0m"
    #	echo -e "Continue?(Y/n) :\c"
    #        read result_9
    #        if [ "${result_9}" == "N" ] || ["${result_9}" == "n" ]; then
    #                exit 0
    #        fi
    #fi
fi

if [ "${editer}" == "1" ]; then
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sleep 4
	sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt-get update
	sudo apt-get -y install code
	echo -e "\033[46;37m VS code was installed successfully! \033[0m"
	echo -e "\033[46;37m (vscode安装成功!) \033[0m"
	sleep 3

elif [ "${editer}" == "2" ]; then
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sleep 2
	sudo apt-get install -y  apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get -y install sublime-text
	echo -e "\033[46;37m The sublime text3 was installed successfully! \033[0m"
	echo -e "\033[46;37m (sublime安装成功!) \033[0m"
	sleep 3
else 
	echo -e"\033[41;37m No editor was installed! \033[0m"	
	echo -e"\033[41;37m (没有安装编辑器!) \033[0m"
	sleep 3
fi


if [ "${browser}" = "1" ]; then
	wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	sudo apt-get update
	sudo apt-get -y install google-chrome-stable
	sudo apt-get purge firefox firefox-locale* unity-scope-firefoxbook

fi

if [ "${Music}" == "1" ]; then
        wget -q http://d1.music.126.net/dmusic/netease-cloud-music_1.1.0_amd64_ubuntu.deb 
	echo -e "Install netease-cloud-music,Please wait...\c"
        sleep 150
	sudo dpkg -i netease-cloud-music*
        sudo apt-get -yf install
        sudo dpkg -i netease-cloud-music*

fi

if [ $LANG == "zh_CN.UTF-8" ]; then
	echo -e "\033[44;37m change directory to english,convenienting command line opration. \033[0m"
	echo -e "\033[44;37m (改变中文目录为英文，方便命令行操作.) \033[0m"
    sleep 4
    
    export LANG=en_US
    xdg-user-dirs-gtk-update
    export LANG=zh-CN

fi

clear

echo -e "成功执行以下操作：***************************" | tee install.log
if [ "${ChangeSources}" == "y" ]; then
    echo -e "- 更换USTC源                                *" | tee -a install.log
fi
if [ "${Update}" == "y" ]; then
    echo -e "- 更新系统软件到最新版本                    *" | tee -a install.log
fi
    echo -e "- 更换目录为英文(若是中文目录的话)          *" | tee -a install.log
if [ "${DualBoot}" == "y" ]; then
    echo -e "- 同步windows/Ubuntu双系统时间(若是双系统)  *" | tee -a install.log
fi
if [ "${Vim}" == "y" ]; then
    echo -e "- 安装vim                                   *" | tee -a install.log
fi
if [ "${Openjdk}" == "y" ]; then
    echo -e "- 安装openjdk8                              *" | tee -a install.log
fi
echo -e "- 删除Amazon的链接                          *" | tee -a install.log
if [ "${Sysmonitor}" == "y" ]; then
    echo -e "- 安装标题栏网速监控软件                    *" | tee -a install.log
fi
if [ "${SystemBeautification}" == "y" ]; then
    echo -e "- 系统美化                                  *" | tee -a install.log
fi
if [ "${Uget}" == "y" ]; then
    echo -e "- 安装uGet下载管理器                        *" | tee -a install.log
fi
if [ "${Typora}" == "y" ]; then
    echo -e "- 安装Typora优雅的markdown编辑器            *" | tee -a install.log
fi
if [ "${editer}" == "1" ]; then
    echo -e "- 安装VS code编辑器                         *" | tee -a install.log
elif [ "${editer}" == "2" ]; then
    echo -e "- 安装sublime text3编辑器                   *" | tee -a install.log
fi
if  [ "${YN}" == "1" ] ; then
    echo -e "- 安装搜狗中文输入法                        *" | tee -a install.log
fi
if [ "${browser}" = "1" ]; then
    echo -e "- 安装Chrome                                *" | tee -a install.log
fi
if [ "${Music}" == "1" ]; then
    echo -e "- 安装网易云音乐                            *" | tee -a install.log
fi
echo -e "*********************************************" | tee -a install.log
echo -e "(配置信息保存在install.log文件中.)"
echo -e "\033[46;37m The configuration is complete.(配置完成!) \033[0m"
echo -e "请重启后按照以下页面配置:https://github.com/starFalll/Ubuntu_Init/blob/master/README.md#sogou-pinyin-input-method-configuration"

echo -e "Reboot now?(是否立即重启？)(Y/n) :\c"
read result_7



if [ "${result_7}" == "Y" ] || [ "${result_7}" == "y" ]; then
	sudo reboot
elif [ "${result_7}" == "N" ] || [ "${result_7}" == "n" ]; then
	echo -e "\033[41;37m Please reboot later.(请稍后重启) \033[0m"
fi






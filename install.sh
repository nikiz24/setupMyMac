#! /bin/bash

# 安装Homebrew
install_homebrew(){
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo '👍  为了让brew运行更加顺畅，将使用中国科学技术大学USTC提供的镜像，更新中，请等待...'
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
}

# GUI软件包清单
# 在这里添加或者删除你需要的GUI软件包名称
brew_cask_app_list=(
QQ
shadowsocksX-ng
wechat
iina
jietu
microsoft-teams
android-studio
sogouinput
android-platform-tools
iterm2
google-chrome
pycharm
)

# 安装GUI软件包
install_cask_app(){
for app in ${brew_cask_app_list[@]}; do
brew cask install $app
done
}

# CLI软件包清单
brew_cli_app_list=(
python3
zsh
wget
vim
rtmpdump
portaudio
ffmpeg
tree
)

# 安装CLI软件包
install_cli_app(){
for app in ${brew_cli_app_list[@]};do
brew install $app
done
}

# 使用zsh
replace_zsh(){
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
}

# 安装Python3环境
install_python_env(){
mkdir ~/.pip
cd ~/.pip
echo "[global]" >> pip.conf
echo "index-url=http://mirrors.aliyun.com/pypi/simple/" >> pip.conf
echo "[install]" >> pip.conf
echo "trusted-host=mirrors.aliyun.com" >> pip.conf
}

# Python3 软件
install_python_app_list(){
PyAudio
opencv-python
pillow
pydub
pyautogui
easygui
allure-pytest
aiohttp
pytest-allure-adaptor
psutil
matplotlib
ffmpeg-python
python-librtmp
PyAudio
pyechartsrobotframework
pytest-rerunfailures
atomicwrites
attrs
backports.functools-lru-cache
certifi
chardet
cycler
funcsigs
idna
matlab
more-itertools
numpy
pluggy
pyparsing
pytest
pytest-html
pytest-instafail
pytest-metadata
pytest-randomly
pytest-repeat
pytest-timeout
python-dateutil
pytz
PyUserInput
requests
six
urllib3
websocket-client
git+https://github.com/Projectplace/pytest-tags
}

# 安装Python3软件
install_python_soft(){
pip3 install ffmpeg-python
for app in ${install_python_app_list[@]};do
pip3 install $app
done
}

# 这里只是用于提示用户，使用Ctrl C退出
read -t 5 -p "按下任意键继续，如需退出，请按Ctrl C，倒计时5秒  \n" user_command
if command -v brew > /dev/null 2>&1; then
echo -e '您的Mac已经安装了homebrew，即将为您安装列表中的软件包🍻  \n'
else
echo '您的Mac OS尚未安装homebrew，正准备为您安装🍻  '
install_homebrew
brew update
fi
install_cask_app
install_cli_app
replace_zsh
install_python_env
install_python_soft

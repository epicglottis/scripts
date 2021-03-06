#!/bin/sh

echo "Installing tools and dependencies..."
# i3
sudo echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/source.list
sudo apt-get --allow-unauthenticated install sur5r-keyring
# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install -qq vim tmux git i3 rxvt-unicode-256color exuberant-ctags aptitude curl netcat nmap htop glances google-chrome-stable xbacklight pavucontrol indicator-cpufreq feh nm-applet golang mercurial compton

echo "Removing local dotfiles..."
cd
rm -f .vimrc .tmux.conf .ps1 .bashrc .Xdefaults .i3status.conf .gitconfig README.md colors.png
rm -rf .i3/ .irssi/ .vim/ scripts/

echo "Cloning dotfiles..."
cd
git init
git remote add origin https://github.com/epicglottis/dotfiles.git
git pull -q origin master
rm -rf .git
source ~/.bashrc

echo "Cloning scripts..."
mkdir -p ~/scripts
cd ~/scripts
git init
git remote add origin https://github.com/epicglottis/scripts.git
git pull -q origin master
rm -rf .git

echo "Grabbing fonts..."
mkdir -p /tmp/fonts
cd /tmp/fonts
wget --quiet "https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip"
unzip -qo 1.017R.zip
sudo cp source-code-pro-1.017R/OTF/*.otf /usr/local/share/fonts/

wget --quiet "https://github.com/powerline/fonts/blob/master/Cousine/Cousine%20for%20Powerline.ttf?raw=true"
mv "Cousine for Powerline.ttf?raw=true" "Cousine for Powerline.ttf"
sudo cp Cousine*.ttf /usr/local/share/fonts/
fc-cache -f

echo "Installing Vundle..."
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "Installing drive..."
source ~/.bashrc
go get -u github.com/odeke-em/drive/cmd/drive

echo "All done! :)"

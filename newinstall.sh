#!/bin/sh

echo "Installing tools and dependencies..."
sudo apt-get install -qq vim tmux git i3 rxvt-unicode-256color exuberant-ctags aptitude curl netcat nmap htop glances

BITS="$(uname -m)"
cd /tmp
if [[ $BITS == *"64"* ]]
then
  echo "Installing 64bit Chrome"
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
else
  echo "Installing 32bit Chrome"
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
fi
sudo dpkg -i google-chrome*
sudo apt-get -fy install

echo "Removing local dotfiles..."
cd
rm .vimrc .tmux.conf .ps1 .bashrc .Xdefaults .i3status.conf
rm -rf .i3/ .irssi/ .vim/

echo "Cloning dotfiles..."
cd
git init
git remote add origin https://github.com/epicglottis/dotfiles.git
git pull origin master
rm -rf .git
source ~/.bashrc

echo "Cloning scripts..."
mkdir -p ~/scripts
cd ~/scripts
git init
git remote add origin https://github.com/epicglottis/scripts.git
git pull origin master
rm -rf .git

echo "Grabbing fonts..."
mkdir -p /tmp/fonts
cd /tmp/fonts
wget --quiet "https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip"
unzip -qo 1.017R.zip
sudo cp source-code-pro-1.017R/OTF/*.otf /usr/local/share/fonts/
fc-cache -f

echo "Installing Vundle..."
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "All done! :)"

#!/bin/sh

echo "Installing tools and dependencies..."
sudo apt-get install -qq vim tmux git rxvt-unicode-256color exuberant-ctags aptitude curl

echo "Removing local dotfiles..."
cd
rm .vimrc .tmux.conf .ps1 .bashrc .Xdefaults
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

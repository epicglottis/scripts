#!/bin/sh

# $ wget https://raw.githubusercontent.com/epicglottis/scripts/master/newinstall.sh > ~/scripts/newinstall.sh
# $ chmod +x ~/scripts/newinstall.sh && ~/scripts.newinstall.sh
echo "Installing tools and dependencies..."
sudo apt-get install -qq vim tmux git rxvt-unicode-256color exuberant-ctags

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

echo "Installing Vundle..."
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "All done! :)"

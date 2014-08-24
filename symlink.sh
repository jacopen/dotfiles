CURRENT=`pwd` 
git submodule update --init --recursive
mv ~/.vimrc ~/.vimrc.bak
mv ~/.screenrc ~/.screenrc.bak
mv ~/.zshenv ~/.zshenv.bak
mv ~/.zshrc ~/.zshrc.bak
mv ~/.vim ~/.vim.bak
mv ~/.byobu ~/.byobu.bak
mv ~/.gitconfig ~/.gitconfig.bak
mv ~/.ssh/config ~/.ssh/config.bak
mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s $CURRENT/.vimrc ~/.vimrc
ln -s $CURRENT/.screenrc ~/.screenrc
ln -s $CURRENT/.zshenv ~/.zshenv
ln -s $CURRENT/.zshrc ~/.zshrc
ln -s $CURRENT/.vim ~/.vim
ln -s $CURRENT/.byobu ~/.byobu
ln -s $CURRENT/.gitconfig ~/.gitconfig
ln -s $CURRENT/private/.ssh_config ~/.ssh/config
ln -s $CURRENT/.tmux.conf ~/.tmux.conf

2015-04-21
==========

rm -rf ~/.vim/bundle/
rm -rf ~/.config/powerline/
cd ~/.dotfiles/
git submodule update --init --recursive
deploy.sh
vim +PluginInstall +qall
pip install --upgrade --user powerline-status

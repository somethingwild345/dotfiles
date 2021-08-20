#!/bin/bash

# git
cp ../git/{.gitconfig,.gitmessage} ~

# .local
mkdir ~/.local/bin
cp ../devicon-lookup ~/.local/bin/
cp -r ../{fonts,gedit} ~/.local/share/

# .config
ln -sr ../kitty ~/.config/
ln -sr ../mpv ~/.config/
ln -sr ../nvim ~/.config/
ln -sr ../ranger ~/.config/
ln ../starship.toml ~/.config/

# general
cp -r ../{.aws,.ssh} ~
mkdir ~/.npm-global
cp -r ../.npmrc ~
ln ../tmux/tmux.conf ~/.tmux.conf
ln ../zsh/zshrc ~/.zshrc

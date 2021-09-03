#!/bin/bash

# Kitty
sed -i 's/theme_dark.conf/theme_light.conf/g' ~/.config/kitty/kitty.conf

# Neovim
sed -i "s/opt.background = 'dark'/opt.background = 'light'/g" ~/.config/nvim/lua/config/colorscheme.lua
sed -i "s/theme = 'gruvbox'/theme = 'gruvbox_light'/g" ~/.config/nvim/lua/config/lualine.lua

# Tmux
sed -i "s/set -g @tmux-gruvbox 'dark'/set -g @tmux-gruvbox 'light'/g" ~/.tmux.conf

# Codium
sed -i "s/Default Dark+/Default Light+/g" ~/.config/VSCodium/User/settings.json

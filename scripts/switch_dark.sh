#!/bin/bash

# Kitty
sed -i 's/theme_light.conf/theme_dark.conf/g' ~/.config/kitty/kitty.conf

# Neovim
sed -i "s/opt.background = 'light'/opt.background = 'dark'/g" ~/.config/nvim/lua/config/colorscheme.lua
sed -i "s/light_melya/dark_catppuccino/g" ~/.config/nvim/lua/config/colorscheme.lua

# Tmux
sed -i 's/theme_light.conf/theme_dark.conf/g' ~/.tmux.conf

# Codium
sed -i "s/Default Light+/Default Dark+/g" ~/.config/VSCodium/User/settings.json

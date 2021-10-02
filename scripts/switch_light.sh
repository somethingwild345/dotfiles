#!/bin/bash

# Kitty
sed -i 's/theme_dark.conf/theme_light.conf/g' ~/.config/kitty/kitty.conf

# Neovim
sed -i "s/opt.background = 'dark'/opt.background = 'light'/g" ~/.config/nvim/lua/config/colorscheme.lua
sed -i "s/dark_catppuccino/light_melya/g" ~/.config/nvim/lua/config/colorscheme.lua
# Tmux
sed -i 's/theme_dark.conf/theme_light.conf/g' ~/.tmux.conf

# Codium
sed -i "s/Default Dark+/Default Light+/g" ~/.config/VSCodium/User/settings.json

#!/bin/bash

# Kitty
sed -i 's/theme_light.conf/theme_dark.conf/g' ~/.config/kitty/kitty.conf

# Neovim
sed -i "s/opt.background = 'light'/opt.background = 'dark'/g" ~/.config/nvim/lua/config/colorscheme.lua
sed -i "s/g.tokyonight_style = 'day'/g.tokyonight_style = 'night'/g" ~/.config/nvim/lua/config/colorscheme.lua

# Tmux
sed -i "s/set -g @tmux-gruvbox 'light'/set -g @tmux-gruvbox 'dark'/g" ~/.tmux.conf

# Codium
sed -i "s/Default Light+/Default Dark+/g" ~/.config/VSCodium/User/settings.json

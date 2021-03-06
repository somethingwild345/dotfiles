#!/bin/bash

# alacritty
sed -i 's/dark_scheme/light_scheme/g' ~/.config/alacritty/alacritty.yml

# Neovim
sed -i "s/opt.background = 'dark'/opt.background = 'light'/g" ~/.config/nvim/lua/config/colorscheme.lua
sed -i "s/fox = 'nightfox'/fox = 'dawnfox'/g" ~/.config/nvim/lua/config/colorscheme.lua
# sed -i "s/'zenflesh'/'zenbones'/g" ~/.config/nvim/lua/config/statusline.lua

# Tmux
sed -i 's/theme_dark.conf/theme_light.conf/g' ~/.tmux.conf

# Codium
sed -i "s/Default Dark+/Default Light+/g" ~/.config/VSCodium/User/settings.json

#!/bin/bash

# alacritty
sed -i 's/light_scheme/dark_scheme/g' ~/.config/alacritty/alacritty.yml

# Neovim
sed -i "s/opt.background = 'light'/opt.background = 'dark'/g" ~/.config/nvim/lua/config/colorscheme.lua
sed -i "s/fox = 'dawnfox'/fox = 'nightfox'/g" ~/.config/nvim/lua/config/colorscheme.lua
# sed -i "s/'zenbones'/'zenflesh'/g" ~/.config/nvim/lua/config/statusline.lua

# Tmux
sed -i 's/theme_light.conf/theme_dark.conf/g' ~/.tmux.conf

# Codium
sed -i "s/Default Light+/Default Dark+/g" ~/.config/VSCodium/User/settings.json

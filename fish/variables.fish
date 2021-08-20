# misc
set -gx LANG "en_US.UTF-8"
set -gx MANPATH $MANPATH /usr/share/man
set -gx EDITOR nvim

# fzf
set -gx FZF_DEFAULT_COMMAND "rg --files --follow --hidden --ignore-file '/home/muhammad/workspace/dotfiles/.fzfignore'"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_DEFAULT_OPTS "--layout=reverse --info=inline --height=60%"


# golang
set -gx GOPATH "$HOME/workspace/go"

# nnn
set -gx NNN_FIFO "/tmp/nnn.fifo"
set -gx NNN_PLUG "p:preview-tui"

# npm
set -gx NPM_PACKAGES "$HOME/.npm-global"
set -gx MANPATH $MANPATH "$NPM_PACKAGES/share/man"
set -gx PATH $PATH "$NPM_PACKAGES/bin"

# yarn
set -gx PATH $PATH "$HOME/.yarn/bin"

# BAT
set -gx BAT_THEME ansi-dark

# PATH
set -gx PATH $PATH "$HOME/.local/bin"
set -gx PATH $PATH "$HOME/.config/composer/vendor/bin"
set -gx PATH $PATH "$HOME/.cargo/bin"
set -gx PATH $PATH "$GOPATH/bin"

# docker-compose
set -gx DOCKER_HOST unix:///run/user/(id -u)/podman/podman.sock


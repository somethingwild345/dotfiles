source ~/.config/fish/variables.fish
source ~/.config/fish/alias.fish
source ~/.config/fish/abbr.fish

# Bitwarden
function bwu
    set -xU BW_SESSION (bw unlock --raw $argv[1])
end

# Load Startship
starship init fish | source

# zoxide
zoxide init fish | source

# Disable greeting message
set -U fish_greeting

# vi key bindings by default
# set -g fish_key_bindings fish_vi_key_bindings

# Play sound when showing notifications.
set -U __done_notify_sound 1
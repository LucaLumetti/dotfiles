export fpath=(~/.oh-my.zsh/custom/complions $fpath)
export PATH="$HOME/.local/scripts:$HOME/.local/bin:$PATH"

# defaults
export EDITOR="nvim"
export SYSTEMD_EDITOR=$EDITOR
export TERMINAL="alacritty"
export BROWSER="google-chrome-stable"

# clenup home
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"

source .bw_session # placed outside just to avoi it in the repository

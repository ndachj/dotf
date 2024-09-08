# ~/.profile
# symlink to `.zprofile` or `.zsh_profile`
# symlink to `.bash_profile`

##### Default programs
export BROWSER='firefox'
export EDITOR="nvim"
export LANG='en_US'
export TERMINAL='alacritty'
export VISUAL='nvim'

##### Add PATH
if [[ -d "$HOME/.bin" ]]; then
    PATH="$HOME/.bin:$PATH"
fi
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# directory to search for shell startup files (.zshrc, etc), if not $HOME.
if [[ -n "$ZSH_VERSION" ]]; then
    export ZDOTDIR="$HOME/.config/zsh"
fi

# view manpages in Nvim - See `:help ft-man-plugin`
export MANPAGER='nvim +Man!'

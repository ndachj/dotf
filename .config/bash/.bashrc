# ~/.bashrc

# <------- ------- ------- ------- ------->
# Ndachj <https://github.com/ndachj/dotf>
# <------- ------- ------- ------- ------->

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

####### Preferences #######
# defined in the `~/.bash_profile`
# export BROWSER='firefox'
# export EDITOR="nvim"
# export LANG='en_US'
# export TERMINAL='alacritty'
# export VISUAL='nvim'
# export MANPAGER='nvim +Man!' # view manpages in Nvim - See `:help ft-man-plugin`

####### Options #######
# See `man bash`
shopt -s autocd               # perform the `cd` command if the command is a directory
shopt -s cdspell              # correct minor errors in the spelling of a directory
shopt -s checkwinsize         # check the window size after each external command and, if necessary, updates the values of LINES and COLUMNS.
shopt -s cmdhist              # save multiple-line command in the same history entry
shopt -s dotglob              # includes filenames beginning with a `.' in the results of pathname expansion.
shopt -s expand_aliases       # expand aliases
shopt -s globskipdots         # never match the filenames '.' and '.', even if the pattern begins with a '.'
shopt -s interactive_comments # Allow comments even in interactive shells
shopt -s progcomp             # enable programmable completion facilities

####### History #######
# appended history to the $HISTFILE when the shell exits, rather than overwriting it
shopt -s histappend
# Where to store the history data
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/.bash_history"
# The maximum no. of events stored in the internal history list
export HISTSIZE=500
# The maximum no. of lines contained in the history file.
export HISTFILESIZE=5000
# erase duplicates, ignore duplicates, ignore space when saving events in the history list
export HISTCONTROL=erasedups:ignoredups:ignorespace

####### Keybindings #######
set -o emacs

####### Aliases #######
# Alias definitions.
# You may want to put all your additions into a separate file instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f "$BDOTDIR/.bash_aliases" ]; then
    . "$BDOTDIR/.bash_aliases"
fi

# enable color support of ls, less and man
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'  # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'  # begin bold
    export LESS_TERMCAP_me=$'\E[0m'     # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m' # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'     # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'  # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'     # reset underline
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable this,
# if it's already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

####### Prompt #######
shopt -s promptvars # enable parameter expansion, command substitution, arithmetic expansion, and quote removal in the prompt
# PS1='[\u@\h \w$] \$ '

if [ -f "$BDOTDIR/git-prompt.sh" ]; then
    source "$BDOTDIR/git-prompt.sh"
    source "$BDOTDIR/git-completion.bash"
    # prompt generated using <https://github.com/Scriptim/bash-prompt-generator>
    PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'
    PS1='\n\[\e[38;5;244m\]$?\[\e[0m\] \[\e[38;5;244m\][\[\e[0m\]\u@\h \[\e[38;5;33m\]\w\[\e[38;5;76m\]${PS1_CMD1}\[\e[38;5;245m\]]\[\e[0m\]\n\$ '
else
    PS1='\[\e[38;5;244m\][\[\e[0m\]\u@\h \[\e[38;5;33m\]\w\[\e[38;5;245m\]]\[\e[0m\] \$ '
fi

####### Plugins #######
# fzf <https://github.com/junegunn/fzf>
if command -v fzf &>/dev/null; then
    # enable fzf key bindings (CTRL-T, CTRL-R, ALT-C) and fuzzy completion
    eval "$(fzf --bash)"
    export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border=rounded --prompt=' '"
    export FZF_DEFAULT_COMMAND='fd --type f' # use `fd` instead of `find`
fi

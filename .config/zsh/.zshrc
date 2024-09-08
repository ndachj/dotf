# ~/.zshrc
#
# <------- ------- ------- ------- ------->
# Ndachj <https://github.com/ndachj/dotf>
# <------- ------- ------- ------- ------->


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# --- lazy.zsh configurations:start --->
# your plugins
declare -x LAZYZ_PLUGINS=(
    Aloxaf/fzf-tab                     # github short url
    https://github.com/ndachj/lazy.zsh # full url
    romkatv/powerlevel10k
    akash329d/zsh-alias-finder
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting
)

export LAZYZ="$HOME/.local/share/lazyz" # where to save plugins
export LAZYZ_UPDATE_REMAINDER=true      # set a reminder
export LAZYZ_UPDATE_INTERVAL=14         # update interval(days)

# bootstrap lazy.zsh
function -lazyz_bootstrap(){
    if ! source "${LAZYZ}/lazy.zsh/lazy.zsh"; then
        if command -v git &>/dev/null; then
            rm -rf "${LAZYZ}/" &>/dev/null
            git clone --depth=1 'https://github.com/ndachj/lazy.zsh' "${LAZYZ}/lazy.zsh"
        else
            echo "[lazyz]: lazy.zsh couldn't be installed."
        fi
    fi
}
-lazyz_bootstrap
# --- lazy.zsh configurations:end --->


####### Preferences #######
# defined in the `~/.zprofile`
# ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh" # directory to search for shell startup files (.zshrc, etc), if not $HOME.
# export EDITOR='nvim'
# export VISUAL='nvim'
# export BROWSER='firefox'
# export TERMINAL='alacritty'
# export MANPAGER='nvim +Man!' # view manpages in Nvim - See `:help ft-man-plugin`


####### Options #######
# See `man zshoptions`
setopt AUTO_CD               # perform the `cd` command if the command is a directory
setopt AUTO_PUSHD            # make `cd` push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS     # don't push duplicates directory onto the directory stack
setopt INTERACTIVE_COMMENTS  # Allow comments even in interactive shells


####### Completion #######
autoload -Uz compinit && compinit
if ( command -v fzf ) &>/dev/null; then
    # fzf-tab <https://github.com/Aloxaf/fzf-tab>
    # fzf-tab needs to be loaded after `compinit`
    source "${LAZYZ}/fzf-tab/fzf-tab.plugin.zsh"
    export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border=rounded --prompt=' '"
    export FZF_DEFAULT_COMMAND='fd --type f' # use `fd` instead of `find`
    source <(fzf --zsh)                      # enable fzf key bindings (CTRL-T, CTRL-R, ALT-C) and fuzzy completion

    # disable sort when completing `git checkout`
    zstyle ':completion:*:git-checkout:*' sort false
    # set descriptions format to enable group support
    zstyle ':completion:*:descriptions' format '[%d]'
    # set list-colors to enable filename colorizing
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    zstyle ':completion:*' menu no
    # preview directory's content with eza when completing cd
    # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    # switch group using `<` and `>`
    zstyle ':fzf-tab:*' switch-group '<' '>'
else # otherwise use the native zsh completion
    zstyle ':completion:*' menu select
    zstyle ':completion:*' special-dirs true # complete . and .. directories
fi


####### History #######
setopt EXTENDED_HISTORY        # format the history events i.e ': <beginning time>:<elapsed seconds>;<command>'
setopt SHARE_HISTORY           # share history across multiple zsh sessions
setopt INC_APPEND_HISTORY      # add commands (as soon as they are entered), rather than waiting until the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST  # expire duplicates history events first
setopt HIST_IGNORE_DUPS        # ignore duplicates when saving to the history list
setopt HIST_FIND_NO_DUPS       # ignore duplicates when searching
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks when adding to the history list

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/.zsh_history"  # where to store the history data
HISTSIZE=3000  # maximum no. of events stored in the internal history list
SAVEHIST=5000  # maximum no. of history events to save in the history file


####### Bindkey #######
# run `bindkey` to see all defined keybindings
bindkey -e  # Emacs editing mode

# Start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search

# Start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[B' down-line-or-search

bindkey '^[[H' beginning-of-line  # [Home] - Go to beginning of line
bindkey '^[[F' end-of-line        # [End] - Go to end of line

# [Control-x Control-e] Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Set terminal window title
case "$TERM" in
    cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty*|st*|foot*|contour*)
        print -Pn "\e]2;${2:q}\a"  # set window name
        print -Pn "\e]1;${1:q}\a"  # set tab name
        ;;
    *)
        ;;
esac

####### Aliases #######
alias dotf="/usr/bin/git --git-dir=${HOME}/.dotf/ --work-tree=${HOME}" # dotfiles

alias zshrc="$EDITOR $ZDOTDIR/.zshrc" # Quick access to the ~/.zshrc file

alias ll='ls -lh'      # long list, human readable
alias la='ls -lAFh'    # long list, show almost all, show type, human readable
alias lt='ls -ltFh'    # long list, sorted by date, show type, human readable
alias lr='ls -tRFh'    # sorted by date, recursive, show type, human readable
alias ldot='ls -ld .*' # list dot file

alias cd1='cd +1'
alias cd2='cd +2'
alias cd3='cd +3'

alias tree='tree -CAhF --dirsfirst'

# change your default USER shell
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now Log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now Log out.'"

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'


####### Functions #######
# backup or unbackup a FILE (*.bak_date)
function unbackup backup(){
    if [[ "$1" == "-u" ]] && [[ -r "$2" ]]; then
        # ISSUE: unable to parser other backup files due to hardcoded string slicing
        cp -r "$2" "${2::-15}" # unbackup (and don't delete the *.bak file)
    elif [[ -r "$1" ]]; then
        mv "$1" "$1.bak$(date +%y%m%d_%H%M)" # backup
    else
        echo  "Usage: backup [-u for unbackup]... FILE"
        echo "backup or unbackup a FILE from/to FILE.bak$(date +%Y%m%d_%H%M)"
        return 1
    fi
}

# extract an archive
function extract (){
    if [[ -f "$1" ]] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"
                ;;
            *.tar.gz)    tar xzf "$1"
                ;;
            *.tar.xz)    tar xJf "$1"
                ;;
            *.bz2)       bunzip2 "$1"
                ;;
            *.rar)       unrar x "$1"
                ;;
            *.gz)        gunzip "$1"
                ;;
            *.tar)       tar xf "$1"
                ;;
            *.tbz2)      tar xjf "$1"
                ;;
            *.tgz)       tar xzf "$1"
                ;;
            *.zip)       unzip "$1"
                ;;
            *.Z)         uncompress "$1"
                ;;
            *.7z)        7z x "$1"
                ;;
            *)
                echo "UnsupportedFileTye: $1 cannot be extracted"
                return 1
                ;;
            esac
    else
                echo "Usage: extract FILE"
                echo "extract an archive"
                return 1
    fi
}

# go up a specified number of directories (i.e. up 4)
function up() {
    declare d
    declare -i limit="$1"
    if [[ -z "$limit" ]] || [[ "$limit" -le 0 ]];then
        limit=1 # default (1 level up)
    fi
    for (( i=1; i<=limit; i++ )); do
        d="../$d"
    done
    cd "$d" || return 1
}

# grep text in all files in the current working directory
# alternative: `ripgrep` <https://github.com/BurntSushi/ripgrep>
function greptext() {
    # Options:
    #   -i case-insensitive
    #   -I ignore binary files
    #   -H causes filename to be printed
    #   -r recursive search
    #   -n causes line number to be printed
    # Optional:
    #   -F treat search term as a literal, not a regular expression
    if [[ -n "$1" ]]; then
        grep -iIHrn --exclude-dir='.git' --color=always "$1" . | less -r
    else
        echo "Usage: greptext TEXT"
        echo "grep text in all files in the current working directory"
        return 1
    fi
}

# get my public & private IP address
# alias whatismyip to myip
function whatismyip myip(){
    if ( command -v ifconfig && command -v curl ) &>/dev/null; then
        echo -n 'Private IP: '; ifconfig wlan0 | grep "inet " | awk '{print $2}'  # Private IP
        echo -n 'Public IP: '; curl -s ifconfig.me                                # Public IP
    else
        echo "Usage: whatismyip or myip"
        echo "MissingDependencies: 'curl' and 'ifconfig' must be installed."
        return 1
    fi
}

# git clone and goto the repo
function clone() {
    git clone --depth=1 "$1" && cd "$(basename ${1%%.git})"
}

# mkdir and goto the dir
function mkdirg() {
    mkdir -p "$@" && cd "${@:$#}"
}


####### Plugins #######
# zsh-autosuggestions
source "$LAZYZ/zsh-autosuggestions/zsh-autosuggestions.zsh"

# powerlevel10k zsh theme
source "$LAZYZ/powerlevel10k/powerlevel10k.zsh-theme"

# zsh-alias-finder
source "$LAZYZ/zsh-alias-finder/zsh-alias-finder.plugin.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"

# zsh-syntax-highlighting
source "$LAZYZ/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

####### Prompt #######
# uncomment to use my zsh prompt theme
# The prompt displays:
#       - return status
#       - hostname
#       - username
#       - current working directory
#       - git branch
#       - user privileges (in a new line)
# The right side prompt displays:
#       - current time in 24-hour format, with seconds

# <------- prompt uncomment:start ------->
# setopt PROMPT_SUBST  # perform substitutions within prompts
# autoload -Uz vcs_info 
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# zstyle ':vcs_info:git:*' formats '%F{240}(%F{yellow}%b%F{240})%f'
# zstyle ':vcs_info:*' enable git
#
# PROMPT='%(?..%F{red}%?)%f %F{green}%n@%m%f %F{240}[%B%F{blue}%~%b%F{240}]%f $vcs_info_msg_0_
# %(!.#.❯) '
# RPROMPT='%F{245}%*$f'  # right side prompt
# <------- prompt uncomment:end ------->


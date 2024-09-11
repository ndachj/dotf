# ~/.bash_aliases
# sourced by `.bashrc`

alias dotf="/usr/bin/git --git-dir=${HOME}/.dotf/ --work-tree=${HOME}" # dotfiles

alias bashrc="$EDITOR $BDOTDIR/.bashrc" # Quick access to the ~/bashrc file

alias ll='ls -lh'      # long list, human readable
alias la='ls -lAFh'    #long list, show almost all, show type, human readable
alias lt='ls -ltFh'    # long list, sorted by date, show type, human readable
alias lr='ls -tRFh'    # sorted by date, recursive, show type, human readable
alias ldot='ls -ld .*' # list dot file

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias tree='tree -CAhF --dirsfirst'

# change your default USER shell
alias tobash="sudo chsh ${USER} -s /bin/bash && echo 'Now Log out.'"
alias tozsh="sudo chsh ${USER} -s /bin/zsh && echo 'Now Log out.'"

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

####### Functions #######
# extract an archive
function extract() {
    if [[ -f "$1" ]]; then
        case $1 in
        *.tar.bz2)
            tar xjf "$1"
            ;;
        *.tar.gz)
            tar xzf "$1"
            ;;
        *.tar.xz)
            tar xJf "$1"
            ;;
        *.bz2)
            bunzip2 "$1"
            ;;
        *.rar)
            unrar x "$1"
            ;;
        *.gz)
            gunzip "$1"
            ;;
        *.tar)
            tar xf "$1"
            ;;
        *.tbz2)
            tar xjf "$1"
            ;;
        *.tgz)
            tar xzf "$1"
            ;;
        *.zip)
            unzip "$1"
            ;;
        *.Z)
            uncompress "$1"
            ;;
        *.7z)
            7z x "$1"
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
    local d=''
    declare -i limit="$1"
    if [[ -z "$limit" ]] || [[ "$limit" -le 0 ]]; then
        limit=1 # default (1 level up)
    fi
    for ((i = 1; i <= limit; i++)); do
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
        grep -iIHrn --exclude-dir='.git*' --color=always "$1" . | less -r
    else
        echo "Usage: greptext TEXT"
        echo "grep text in all files in the current working directory"
        return 1
    fi
}

# get my public & private IP address
function myip() {
    if (command -v ifconfig && command -v curl) &>/dev/null; then
        echo -n 'Private IP: '
        ifconfig wlan0 | grep "inet " | awk '{print $2}' # Private IP
        echo -n 'Public IP: '
        curl -s ifconfig.me # Public IP
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

# Announces result of last run command.
# eg. `some_long_command; notify`
function notify {
    status=$?
    if [ $status -eq 0 ]; then
        echo -e "\033[1;32m[ DONE ]\033[0m"
        (say -v Cellos $(printf "%0.s done" {1..26}) &)
    elif [ $status -ne 130 ]; then # Ignore exit with Ctrl-C
        echo -e "\033[1;31m[ ERROR $status ]\033[0m"
        (say "Oh noes, exit code $status" &)
    fi

    return $status
}

# Find a directory below this that matches the word provided
#   (locate-based)
function down() {
    dir=""
    if [ -z "$1" ]; then
        dir=.
    fi
    dir=$(locate -n 1 -r "$PWD.*/$1$") && cd "$dir"
}

# Consider using pgrep instead of grepping 'ps' output
function psgrep() { ps aux | grep -v grep | grep "$@" -i --color=auto; }

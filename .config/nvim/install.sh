#!/usr/bin/env bash

# install.sh
# setup neovim using Ndachj's config

declare NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
declare NVIM_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"

# core packages
declare -a CORE_PKGS=(
    neovim
    git
    fd
    ripgrep
    nodejs
)

# Termux packages
declare -a TERMUX_PKGS=(
    python # python package installs the clang which is required by nvim-treesitter
)

function _fancy_print() {
    local msg=${*}
    echo -e "\e[32;01m #######################################################"
    echo ""
    echo "$msg"
    echo ""
    echo -e "####################################################### \e[0m"
}

function install_pkgs() {
    clear
    fancy_print "Installing core packages ..."
    if [[ -n "$TERMUX_VERSION" ]]; then # running on Termux
        pkg install "${CORE_PKGS[@]}"
        pkg install "${TERMUX_PKGS[@]}"

        # clipboard support
        pkg install x11-repo # add X11 repo
        pkg install xsel termux-api

    else # othewise Debian
        sudo apt install "${CORE_PKGS[@]}" -y

        # clipboard support
        if [[ -n "$WAYLAND_DISPLAY" ]]; then
            sudo apt install wl-clipboard -y # for wayland
        else
            sudo apt install xsel -y # for X11
        fi
    fi

    # Python 3 and Node.js support
    python3 -m pip install pynvim
    npm install -g neovim
}

function copy_nvim_config() {
    # Backup nvim config, if any
    if [[ -s "${NVIM_CONFIG_DIR}" ]]; then
        _fancy_print "Backing up your nvim config ..."
        mv -v "${NVIM_CONFIG_DIR}" "${NVIM_CONFIG_DIR}_$(date --iso-8601).bak"
    fi

    # Remove the old nvim plugins, if any
    if [[ -s "${NVIM_DATA_DIR}" ]]; then
        _fancy_print "Removing old nvim plugins ...."
        rm -rf --interactive=never "$NVIM_DATA_DIR"
    fi

    # copy the everything dir to `~/.config`
    cp -rf "$(pwd)/../nvim" "${XDG_CONFIG_HOME:-$HOME/.config}"
}

function lsp_setup() {
    # setup development environment for python, bash, lua, toml

    _fancy_print "Installing LSP ...."
    python3 -m pip install flake8
    python3 -m pip install autopep8
    npm install -g bash-language-server

    local LSP_PKGS=(
        shellcheck          # Shell script analysis tool
        shfmt               # A shell parser and formatter
        lua-language-server # Sumneko Lua Language Server coded in Lua
        stylua              # An opinionated Lua code formatter
        taplo               # A TOML LSP and toolkit
    )

    apt install "${LSP_PKGS[@]}" -y
}

# main
install_pkgs
copy_nvim_config
lsp_setup
# start neovim
echo "Now run the command 'nvim'"

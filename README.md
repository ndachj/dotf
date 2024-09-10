# ☕ Ndachj's Dotfiles

```
╭─────────────────────────────────────╮
│    _  __    __            __     _  │
│   / |/ /___/ /___ _ ____ / /    (_) │
│  /    // _  // _ `// __// _ \  / /  │
│ /_/|_/ \_,_/ \_,_/ \__//_//_/_/ /   │
│                             │__/    │
╰─────────────────────────────────────╯
```

This repository contain a copy of my ☕ **dotfiles** (configuration files and scripts).

I store my dotfiles using just a Git bare repository - no symlinks, no extra tools, and no scripts required. See [this blog](https://web.archive.org/web/20240307132655/https://engineeringwith.kalkayan.com/series/developer-experience/storing-dotfiles-with-git-this-is-the-way/) for more details.

> [!important]
> Configurations and scripts in this repository are **HIGHLY PERSONALIZED** to **my own preferences, taste and workflows**. Please review them before using.

## 🔥 Available Configurations

- Text editor or IDE

  - [Neovim](./.config/nvim/README.md)

- Window manager

  - [qtile](./.config/qtile/README.md)

- Shell

  - [Bash](./.bashrc)
  - [Zsh](./data/zsh/README.md)

- Terminal emulator

  - [Alacritty](./config/alacritty/README.md)

- Android emulator

  - [Termux](./.termux/README.md)

## 📂 File Structure

```
/home/$USER/
    ├── .config/
    │   ├── alacritty/
    │   │   └── alacritty.toml
    │   ├── nvim/
    │   │   ├── lua/
    │   │   └── init.lua
    │   ├── qtile/
    │   │   ├── scripts/
    │   │   └── config.py
    │   └── zsh/
    │       ├── .p10k.zsh
    │       └── .zshrc
    └── .local/
        └── bin/
            └── scripts
```

## 🚀 Usage

- I have dropped a `README` file on each folder with the requirements, instructions and post-installation setup.

## 🌐 Contributing

Feel free to fork this repository and customize it for your setup. Pull requests for improvements and bug fixes are welcome.

## 📌 License

This project is licensed under Apache License, Version 2.0.

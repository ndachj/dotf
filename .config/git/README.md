#  Git Configuration

See: `man git-config`

System-wide configuration - `/etc/gitconfig`User(global) configuration - `$XDG_CONFIG_HOME/git/config` or `~/.gitconfig`
Repository(local) configuration - `.git/config`

### Set up your username/email address

```sh
git config --global user.name "Your Username"
git config --global user.email "your-email@example.com"
```

### Enable helpful colorization of git command line output

```sh
git config --global color.ui auto
```

### Set your default editor

```sh
git config --global core.editor "nvim"
```

### Check your current git configuration

```sh
git config --list --show-origin
git config user.name # query username
```

### Set 'main' as default branch name from 'master'

```sh
git config --global init.defaultBranch main
```

### Define Git Aliases: using git alias (place in your global .gitconfig file)

```sh
# get nice formated log
git config --global alias.l "log --graph --pretty=oneline --abbrev-commit --decorate"
```

```sh
# easily undo the last changes you made with a new git undo command
git config --global alias.undo 'reset HEAD~1 --mixed'
```

```sh
# view your last commit
git config --global alias.last 'log -1 HEAD --stat'
```

```sh
# get a list of your git aliases
git config --global alias.list 'config --global -l'
```

## See Also

[commit-conventions](./commit-conventions-instructions.md)

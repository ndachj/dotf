#  How to use

To add the template to your global git config is enter the following:

```sh
git config --global commit.template ~/.config/git/commit-conventions-template.txt
```

Now whenever you’re making a commit, instead of the typical `git commit -m "A brief commit message"`, just enter `git commit` to open your default editor with the template in place. You’ll automatically have a guide to choose conventions from to create a structured message.

- The `header` of the commit message notes the type of the commit as docs and a **brief description that does not exceed 60 characters** to ensure readability (the commented lines are 60 characters long and act as guides for when to use a line break).
- The `body` optionally **elaborates on the changes made**.
- The `footer` optionally notes **any issue/PR the commit is related to**.

_The final message will simply look like this_:

```diff
docs: Update README with contributing instructions

Adds a CONTRIBUTING.md with PR best practices, code style
guide, and code of conduct for contributors.

Closes #9
```

## Vim Setup

_If you use Vim or Neovim, and you want to speed up the process even more, you can add this to your git config:_

```sh
# on Neovim
git config --global core.editor "nvim +16 +startinsert"

# on Vim
git config --global core.editor "vim +16 +startinsert"
```

This sets the default editor to `Neovim (or Vim)`, and **places the cursor on line 16 in Insert Mode as soon the editor opens**.

> [!NOTE]
> You can still use `git commit -m "Your message"` exactly as you did before, but the configuration will default to the template setup when you just type `git commit`.

# Dotfiles

ZSH, TMUX, and Vim. 

## TODO
- use https://github.com/tmux-plugins/tpm
- install https://github.com/tmux-plugins/tmux-yank
## Installation

Once the repo is cloned, execute the deploy script:
```
./deploy
```

This script guides you through the following:

1. Checks to see if you have zsh, tmux, and vim installed. 
2. Installs it using your default package manager if you don't have it installed.
3. Checks to see if your default shell is zsh.
4. Sets zsh to your default shell.
5. Backs up your old configuration files.

Pretty convenient for configuring new servers.

# Sumary of Changes

## Basic runtime opperations 

All default dotfiles (`.zshrc`, `.vimrc`, etc) source something within the dotfiles repository. This helps separate changes that are synced across all your machines with system specific changes.

Upon launching a new shell, the first thing that's evaulated is `zshrc_manager.sh`. This script first launches tmux. Then once zsh logs in, within tmux, it updates the dotfiles repository, and sources the changes.

## [Zsh](https://en.wikipedia.org/wiki/Z_shell)

* `cd` has been reassigned to `cd` and `ls`. Every time you navigate to a new directory, it will display the contents of that directory.
* `v` has been aliased too: `vim -p`. This let's you open multiple files in vim as tabs. 

### Prompt

The prompt takes on the form:

```
[plugin, plugin, ...]: 
```

Each plugin is sensitive to where you are and what you're doing, they reveal themselves when it's contextually relevant. Plugins include:

* `PWD plugin`: always present, tells you where you are. Always the first plugin.
* `Status code plugin`: appears anytime a program returns with a non-zero status code. Tells you what status code the program completed with. 
* `Git plugin`: appears when you're in a git repository. Tells you what branch you're on, and how many files have been changed since the last commit.
* `Sudo plugin`: tells you when you can sudo without a password. Or when you're logged in as root.
* REMOVED `Time plugin`: appears when a program took more than 1s to execute. Tells you how long it took to execute.
* `REMOVED PID plugin`: appears when you background a task. Tells you what the PID of the task is.

### Keybindings
| Key Stroke | What It Does |
|------------|--------------|
| Ctrl-H     | Runs ``cd ~/`` |
| Ctrl-K     | Runs ``cd ..`` |
| Ctrl-G     | Runs ``git add -A; git commit -v && git push`` |
| Ctrl-V     | Runs ``fc``. Takes last command and puts it in a vim buffer. |
| Ctrl-S     | Add's ``sudo`` to the beginning of the buffer. |
| Ctrl-L     | Run's ``ls``. |
| Ctrl-O     | open finder|
| Ctrl-P     | Equivalent to pressing ``up arrow``. |

### Plugins

* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): Searches your history while you type and provides suggestions.
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/tree/ad522a091429ba180c930f84b2a023b40de4dbcc): Provides fish style syntax highlighting for zsh.
* [ohmyzsh](https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3): Borrowed things like tab completion, fixing ls, tmux's vi-mode plugin.
* [vimode-zsh](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode) allows you to hit `esc` and navigate the current buffer using vim movement keys.

## [Vim](https://en.wikipedia.org/wiki/Vim_(text_editor)
* neovim is used
* [install fzf] (https://github.com/junegunn/fzf) 
* Leader key has ben remapped to `,`
 
### fzf update
* git: cd ~/.fzf && git pull && ./install
* vim-plug: :PlugUpdate fzf
## [Tmux](https://en.wikipedia.org/wiki/Tmux)

* isntall [plugins](https://github.com/tmux-plugins/tpm): install with PREFIX+I
* `%` has been remapped to `v`.
* Use vim movement keys for moving between panes. 
* Copy buffer is coppied to xclip.
* Status bar tells you date, time, user, and hostname. Especially useful with nested ssh sessions.
* hjkl to navigate windows
* HJKL to resize window
*
## nvvim installation:
- http://nvim.fisadev.com/


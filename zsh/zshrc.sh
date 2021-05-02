# COLOR 
if [ ! "$TMUX" ]; then 
	export TERM=screen-256color
fi
# Setting fd as the default source for fzf
# needed For nvim:Files
if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
	if (( $+commands[rg] )); then
		export FZF_DEFAULT_COMMAND='rg --files --hidden'
	elif (( $+commands[fd] )); then
		export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
	elif (( $+commands[ag] )); then
		export FZF_DEFAULT_COMMAND='ag -l --hidden -g ""'
	fi
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# Vars
HISTFILE=~/.zsh_history
SAVEHIST=1000
setopt inc_append_history # To save every command before it is executed
setopt share_history # setopt inc_append_history

git config --global push.default current

# Aliases
alias vim="nvim"
alias py="python"
alias v="nvim -p"
alias tmux='tmux -u'
alias tm='tmux'
#mkdir -p /tmp/log

# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
export VISUAL=vim

#Functions
 #Custom cd
c() {
	cd $1;
    ls;
	#ls -U | head -4
}
alias cd="c"

# For vim mappings:
stty -ixon


ZPLUG_HOME=~/.zplug # set in deploy skript
source $ZPLUG_HOME/init.zsh
# To manage zplug itself like other packages, write the following in your .zshrc
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Supports oh-my-zsh plugins and the like
#zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
#zplug "tarrasch/zsh-command-not-found"
#zplug "esc/conda-zsh-completion"
zplug "zsh-users/zsh-completions"
#zplug "desyncr/auto-ls"
#zplug "ryanoasis/nerd-fonts"
zplug "unixorn/git-extra-commands"
zplug "MichaelAquilina/zsh-you-should-use" # alias reminder if not used
#zplug "olivierverdier/zsh-git-prompt"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#zplug "woefe/git-prompt.zsh", use:"{git-prompt.zsh,examples/default.zsh}"
zplug "woefe/git-prompt.zsh"
#zplug "jeffreytse/zsh-vi-mode"
#zplug "Aloxaf/fzf-tab"
#zplug "marlonrichert/zsh-autocomplete"
zplug "dim-an/cod"


#zplug "dim-an/cod" # lean autocompletion with --help
# Then, source plugins and add commands to $PATH

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    echo; zplug install
fi

#zplug load --verbose
zplug load 

source ~/dotfiles/zsh/keybindings.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

source ~/dotfiles/zsh/prompt.sh
export PATH=$PATH:$HOME/dotfiles/utils

# caps to esc
if command -v setxkbmap &> /dev/null
then
	setxkbmap -option caps:escape
fi


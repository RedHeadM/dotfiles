# COLOR 
if [ ! "$TMUX" ]; then 
	export TERM=screen-256color
fi
# Setting fd as the default source for fzf
# needed For nvim:Files
#if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
    if command -v rg &> /dev/null; then
        # --no-ingore-vcs to tell it to not ignore version control files
        # --follow: to include symbolic links
		export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*}"'
    elif command -v ag &> /dev/null; then
		#export FZF_DEFAULT_COMMAND='ag -l -p ~/dotfiles/.gitignore  -g ""'
        export FZF_DEFAULT_COMMAND='ag -l --hidden -p ~/dotfiles/.gitignore  -g ""'
    elif command -v fd &> /dev/null; then
		export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude .git --ignore-file ~/dotfiles/.gitignore'
	fi
#fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# HISTORY
#set history size
export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#history file
export HISTFILE=~/.zhistory

#append into history file
setopt SHARE_HISTORY # INC_APPEND_HISTORY must be off if used
#setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS


setopt HIST_FIND_NO_DUPS
# following should be turned off, if sharing history via setopt SHARE_HISTORY
# ensures that commands are added to the history immediately 
setopt INC_APPEND_HISTORY

git config --global push.default current
# Settings
export VISUAL=vim

# Aliases
alias vim="nvim"
alias vi="nvim"
alias py="python"
alias v="nvim -p"
alias tmux='tmux -u'
alias tm='tmux'
# GIT
# forgit git log 
alias gl='glo'
alias gs='git status'
alias gm='git commit -m'
alias gfp='gf && git pull'
#alias l='git commit -m'

#mkdir -p /tmp/log
# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

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

# ZINIT - UPGINS
# https://github.com/zdharma-continuum/zinit/wiki/%F0%9F%A7%8A-Recommended-ices

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

# forgit
#interactive git log viewer (glo), git add with (ga)
#zinit ice wait lucid
zinit ice wait"2" lucid  
zinit load 'wfxr/forgit'

# Autosuggestions & fast-syntax-highlighting
#zinit ice wait lucid atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
#zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-autosuggestions
#zinit ice wait lucid atload"!_zsh_autosuggest_start"
#zinit load zsh-users/zsh-autosuggestions

# sharkdp/bat used with forgit
#zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
#zinit light sharkdp/bat

# diff-so-fancy
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zinit load zdharma-continuum/zsh-diff-so-fancy

# better auto completions with form --help
zinit ice wait lucid as"program"
zinit load dim-an/cod 

# exa, modern ls
#zinit ice from"gh-r" as"program" mv"exa* -> exa"
#zinit load ogham/exa

#zinit ice wait lucid  
#zinit load  MichaelAquilina/zsh-you-should-use 

# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
# see https://zdharma.github.io/zinit/wiki/LS_COLORS-explanation/
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
 atpull'%atclone' pick"clrs.zsh" nocompile'!' \
 atload='zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}' # <- no `\` here to work with fzf tab
zinit light trapd00r/LS_COLORS

# Replace zsh's default completion selection menu with fzf!
zinit light Aloxaf/fzf-tab 

# git promt setup in prompt.sh
zinit light woefe/git-prompt.zsh

    #atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" zdharma-continuum/fast-syntax-highlighting \

# fix for error zsh-syntax-highlighting: unhandled ZLE widget 'autosuggest-accept'
# https://gitter.im/zdharma/zinit?at=5fe95372de60814315495d48
zinit ice wait"0a" lucid atload'_zsh_autosuggest_start; bindkey "^e" autosuggest-accept;'
zinit light zsh-users/zsh-autosuggestions

zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
    blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions \
    MichaelAquilina/zsh-you-should-use 

#compinit # Refresh installed completions.
# A cat(1) clone with syntax highlighting and Git integration.
#zinit ice wait from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat"
#zinit light sharkdp/bat

# A syntax-highlighting pager for git, diff, and grep output
#zinit ice wait"2" from"gh-r" as"program" mv"delta* -> delta" pick"delta/delta"
#zinit light dandavison/delta
# git config --global interactive.diffFilter "diff-so-fancy --patch"
# diff so fancy, install:
#git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
#git config --global interactive.diffFilter "diff-so-fancy --patch"
zinit ice from"gh-r" as"program" pick"diff-so-fancy"; zinit light so-fancy/diff-so-fancy


source ~/dotfiles/zsh/keybindings.sh
source ~/dotfiles/zsh/fzf_func.sh

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
#export PATH=$PATH:$HOME/dotfiles/utils

# caps to esc
if command -v setxkbmap &> /dev/null
then
	setxkbmap -option caps:escape
fi


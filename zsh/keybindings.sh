# dir up with arrow
	function up_widget() {
		BUFFER="cd .."
		zle accept-line
	}
	zle -N up_widget
	bindkey "^U" up_widget

# git with <ctrl g/G>
	function git_commit() {
		if [ -n "$BUFFER" ];
			then
				BUFFER="git commit -m \"$BUFFER\""
		fi

		if [ -z "$BUFFER" ];
			then
				BUFFER="git commit -v"
		fi
				
		zle accept-line
	}
	zle -N git_commit
	bindkey "^g" git_commit

	function git_prepare() {
		if [ -n "$BUFFER" ];
			then
				BUFFER="git commit -a -m \"$BUFFER\" && git push"
		fi

		if [ -z "$BUFFER" ];
			then
				BUFFER="git add -u && git commit -v && git push"
		fi
				
		zle accept-line
	}
	zle -N git_prepare
	bindkey "^G" git_prepare
    
# home
   # function goto_home() { 
		#BUFFER="cd ~/"$BUFFER
		#zle end-of-line
		#zle accept-line
	#}
	#zle -N goto_home
	#bindkey "^h" goto_home

# Edit and rerun
function edit_and_run() {
    if [ -n "$BUFFER" ];
    then
        # user start writing
        BUFFER="vi \"$BUFFER\""
    else
        # fzf file pick
        #^M or \n is used to represent the Enter key so that the command is run automatically.,cc
        BUFFER="vi \$(fzf)"
    fi
        zle accept-line
}
zle -N edit_and_run
bindkey "^v" edit_and_run

# LS
# function ctrl_l() {
    #BUFFER="ls"
    #zle accept-line
#}
#zle -N ctrl_l
#bindkey "^l" ctrl_l

# Sudo
function add_sudo() {
    BUFFER="sudo "$BUFFER
    zle end-of-line
}
zle -N add_sudo
bindkey "^s" add_sudo

# open finder
function open_finder() {
    # open finder gui window for the current dir 
    if [ -x "$(command -v nautilus)" ]; then
        nautilus .
    elif [ -x "$(command -v open)" ]; then
        # open on max osx
        open .
    fi
}
zle -N open_finder
bindkey "^o" open_finder

# zsh-users/zsh-autosuggestions, accept the current suggestion
bindkey '^e' autosuggest-accept

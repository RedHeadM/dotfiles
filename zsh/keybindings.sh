# dir up with arrow
function up_widget() {
	BUFFER="cd .."
	zle accept-line
}
zle -N up_widget
bindkey "^o" up_widget

# git with <ctrl g/G>
function git_commit() {
	if [ -n "$BUFFER" ];
		then
			BUFFER="git commit -m \"$BUFFER\""
	fi

	if [ -z "$BUFFER" ];
		then
			# BUFFER="git commit -v"
			# open vim with fugitive.vim in full screen
			BUFFER="vi -c ':Git |:on'"
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
bindkey "^p" git_prepare

function ros2_bbnv_setup() {
	export ROS_VERSION=2
	export ROS_PYTHON_VERSION=3
	export ROS_DISTRO=humble
	echo "[INFO] ros2_bbnv_setup start"
	source /opt/ros/humble/setup.zsh
	source /opt/bbnv/setup.zsh
	echo "[INFO] ros2_bbnv_setup end"
	zle accept-line
}
zle -N ros2_bbnv_setup
bindkey "^w" ros2_bbnv_setup

function ros2_topic_completion() {
   
    topic_selected="$(ros2_fzf_topic_select)"
	if [ -z "$topic_selected" ]
	then
		# no seletion do nothing
		return
	fi
    if [ -n "$BUFFER" ];
    then
        # user start writing
	BUFFER="${BUFFER} $topic_selected"
	BUFFER="$BUFFER" | xargs
    else
        BUFFER="ros2 topic echo $topic_selected"
    fi
    zle accept-line
}
zle -N ros2_topic_completion
bindkey "^t" ros2_topic_completion

    
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
        BUFFER="vi $BUFFER"
	zle accept-line
    else
        # fzf file pick
        #^M or \n is used to represent the Enter key so that the command is run automatically.,cc
	selected_file=$(eval $FZF_DEFAULT_COMMAND | fzf)
	if [ -z "$selected_file" ]
	then
		# echo "\$var is empty"
	else
		# nothing selected
		BUFFER="vi $selected_file"
		zle accept-line
	fi
    fi
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

function open_todo() {
    vi ~/my.todo
}
zle -N open_todo
bindkey "^z" open_todo

# open finder
function open_finder() {
    # open finder gui window for the current dir 
    if [ -x "$(command -v nautilus)" ]; then
        nautilus . &
    elif [ -x "$(command -v open)" ]; then
        # open on max osx
        open .
    fi
}
zle -N open_finder
bindkey "^f" open_finder

# zsh-users/zsh-autosuggestions, accept the current suggestion
bindkey '^e' autosuggest-accept

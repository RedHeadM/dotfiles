# from https://github.com/junegunn/fzf/wiki/examples

# fd - cd to selected directory
# usage: fd ; fd .
fcd() {
      local dir
    dir=$(find ${1:-~} -path '*/\.*' \
                  -o -print 2> /dev/null | fzf +m) &&
    if [[ -d $dir ]]
    then
        cd -- $dir
    else
        cd $(dirname $dir)
    fi 
}



# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

# fuzzy grep open via ag with line number
fgrep() {
  local file
  local line

  read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

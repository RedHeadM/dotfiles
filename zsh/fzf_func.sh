# from https://github.com/junegunn/fzf/wiki/examples


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

nvkill(){
    local pid
    pid=$(echo $(nvidia-smi | grep 'python' | awk '{print "pid: "$5 " gpu: " $2 " name: "$7 }'\
        | fzf -m \
        | awk '{print $2}')) # last filter out pid  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

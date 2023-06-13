#!/bin/bash
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


function ros2_topic_preview(){
    topic_name="$1"
    max_echo_lines=20
    echo "TOPIC: $topic_name"
    ros2 topic info $topic_name 
    ros2 topic echo --once $topic_name | head -n $max_echo_lines
}

function ros2_fzf_topic_select(){
    topic_seleted=$(ros2 topic list | fzf --header "ROS2 Topic List fzf" --height 50% \
        --preview "\echo \"TOPIC: {}\" | batcat --style changes -l yaml --color=always  --paging never && \
            ros2 topic info {} | batcat --style changes -l yaml --color=always  --paging never && \
            echo \"---\" && \
            ros2 topic echo --once {} | head -n 25 | batcat --style changes -l yaml --color=always  --paging never"
        )
    echo $topic_seleted  
}

function path_pretty_print(){
    echo "${PATH//:/$'\n'}"
}

tmux new-session -d -s $session
tmux rename-window -t "${session}:0" "shell"

#vim
tmux new-window -n vim
tmux send-keys "${prcmd}; vim" C-m

#panel layout preparation
tmux select-window -t ${window1}
tmux split-window -h -p 50
tmux select-pane -t ${window1}.0
tmux split-window -v -p 50

#commands
tmux send-keys -t ${window1}.0 "${prcmd}; rails c" C-m
tmux send-keys -t ${window1}.1 "${prcmd}; ${scmd}" C-m
tmux send-keys -t ${window1}.2 $prcmd C-m

tmux select-window -t ${window2}

tmux attach -t ${session}


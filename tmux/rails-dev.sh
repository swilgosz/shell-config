
tmux new-session -d -s $session

#shell window
# tmux rename-window -t "${session}:0" "shell"
tmux send-keys -t "${session}:0" $prcmd C-m

#vim
tmux new-window -n vim
tmux send-keys -t "${session}:1" "${prcmd}; vim" C-m

# #rails console and server
tmux new-window -n rails
tmux send-keys -t "${session}:2" "${prcmd}; ${scmd}" C-m
tmux select-window -t "${session}:2"
tmux split-window -h -p 50
tmux send-keys -t ${session}:2.1 "${prcmd}; rails c" C-m

# #focus on vim
tmux select-window -t ${session}:1

tmux rename-window -t "${session}:0" "shell"
tmux rename-window -t "${session}:1" "vim"
tmux rename-window -t "${session}:2" "rails"
#run all
tmux attach -t ${session}


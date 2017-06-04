tmux new-session -d -s $session

#shell window
tmux send-keys -t "${session}:0" $prcmd C-m

#vim
tmux new-window -n vim
tmux send-keys -t "${session}:1" "${prcmd}; vim" C-m

# #rails console and server
tmux new-window -n rails
tmux send-keys -t "${session}:2" "${prcmd}; ${scmd}" C-m
tmux new-window -n console
tmux send-keys -t ${session}:2 "${prcmd}" C-m
tmux send-keys -t ${session}:2 "rails c" C-m

# #focus on vim
tmux select-window -t ${session}:1

tmux rename-window -t "${session}:0" "shell"
tmux rename-window -t "${session}:1" "vim"
tmux rename-window -t "${session}:2" "console"
tmux rename-window -t "${session}:3" "server"

#run all
if [[ ! -n $run ]] || [[ $run != false ]]; then
  tmux attach -t $session
fi


tmux new-session -d -s $session

#shell window
tmux send-keys -t "${session}:0" $prcmd C-m

#vim
tmux new-window -n vim
tmux send-keys -t "${session}:1" "${prcmd}; vim" C-m

#ember server and test
tmux new-window -n tests
# tmux split-window -h -p 50
tmux send-keys -t ${session}:2 "${prcmd}; ${tcmd}" C-m

tmux new-window -n server
tmux send-keys -t "${session}:3" "${prcmd}; ${scmd}" C-m
tmux select-window -t "${session}:3"

# #focus on vim
tmux select-window -t ${session}:1

tmux rename-window -t "${session}:0" "shell"
tmux rename-window -t "${session}:1" "vim"
tmux rename-window -t "${session}:2" "ember tests"
tmux rename-window -t "${session}:3" "ember server"

#run all
if [[ ! -n $run ]] || [[ $run != false ]]; then
  tmux attach -t $session
fi


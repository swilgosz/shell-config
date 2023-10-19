alias soa="source ~/.config/zsh/bash_aliases.sh"

source "$HOME/.config/zsh/aliases/git_bash_aliases.sh"
source "$HOME/.config/zsh/aliases/docker_bash_aliases.sh"
source "$HOME/.config/zsh/aliases/vc_bash_aliases.sh"
source "$HOME/.config/zsh/aliases/ruby_bash_aliases.sh"
source "$HOME/.config/zsh/aliases/tmux_bash_aliases.sh"
source "$HOME/.config/zsh/aliases/vim_bash_aliases.sh"
source "$HOME/.config/zsh/aliases/kube_bash_aliases.sh"

alias lsizes="find . -maxdepth 1 -type d -mindepth 1 -exec du -hs {} \; | sort -n" # list dirs sorted by used space
alias work="cd ~/work"


alias clear_redis="redis-cli FLUSHDB"

alias pj="~/.config/zsh/scripts/prettyjson.sh"

alias x='exit'



alias cdb='cd && cd -'

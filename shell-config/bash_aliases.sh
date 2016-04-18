#git commands
alias ga='git add -p'
alias gaa='git add -A'
alias gan='git add -N'
alias gc='git commit -m' #this allows me to use 'gc "Commit message"'
alias gca='git commit --amend'
alias gl='git pull -r'   #always pull and rebase actuall branch
alias gm='git merge'
alias go='git checkout'
alias gp='git push'      #always push actual branch.
alias gs='git status'
alias gr='git rebase master' #I often rebase with master and almost never with other branches.
alias gri='git rebase -i'

#tmux commands
alias t='tmux attach -t'

#.dot files
alias za='vim ~/bin/shell-config/bash_aliases.sh'
alias zg='vim ~/.gitconfig'
alias zp='vim ~/bin/zsh-plugins'
alias zt='vim ~/bin/tmux/.tmux.conf'
alias zz='vim ~/.zshrc'

#rails aliases
alias ss='spring rspec --color'
alias rake='bundle exec rake'

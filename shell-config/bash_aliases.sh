alias ct='ctags -R --exclude=.git --exclude=node_modules --exclude=bower_components --exclude=tmp'
#git commands
alias ga='git add -p'
alias gaa='git add -A'
alias gan='git add -N'
alias gc='git commit'
alias gcm='git commit -m' #this allows me to use 'gc "Commit message"'
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
alias tl='tmux list-sessions'

#.dot files
alias za='vim ~/bin/shell-config/bash_aliases.sh'
alias zg='vim ~/.gitconfig'
alias zp='vim ~/bin/zsh-plugins'
alias zt='vim ~/bin/tmux/.tmux.conf'
alias zv='vim ~/.vim_runtime/my_configs.vim'
alias zvp='vim ~/.vim_runtime/vimrcs/plugins_config.vim'
alias zz='vim ~/.zshrc'

#rails aliases
alias ss='spring rspec --color'
alias st='spring stop'
alias rake='bundle exec rake'


#source aliases
alias soa='source ~/bin/shell-config/bash_aliases.sh'

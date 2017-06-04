#cd commands
alias vi='nvim'
alias cdv='cd ~/.vim_runtime'
alias cdb='cd ~/bin/'
alias cdp='cd ~/projects'

alias ctags='`brew --prefix`/bin/ctags'
#git commands
alias ga='git add -p'
alias gaa='git add -A'
alias gan='git add -N'
alias gc='git commit'
alias gcm='git commit -m' #this allows me to use 'gc "Commit message"'
alias gcn='git commit --no-edit' #this allows me to use 'git commit' without asking to confirm message
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gl='git pull -r'   #always pull and rebase actuall branch
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n 15"
alias gmy='glog --author="Sebastian Wilgosz"'
alias gm='git merge --no-ff'
alias go='git checkout'
alias gp='git push'      #always push actual branch.
alias gs='git status'
alias gr='git rebase master' #I often rebase with master and almost never with other branches.
alias grb='git branch --merged | xargs git branch -D' #remove all merged branches
alias gri='git rebase -i'

alias lsizes='find . -maxdepth 1 -type d -mindepth 1 -exec du -hs {} \;'
#tmux commands
alias t='tmux attach -t'
alias tl='tmux list-sessions'

alias trim="ex +'bufdo!%s/\s\+$//e' -scxa"
alias retab="ex +'set ts=2' +'bufdo retab' -scxa"

alias x='exit'

#.dot files
alias za='vim ~/bin/shell-config/bash_aliases.sh'
alias zg='vim ~/.gitconfig'
alias zp='vim ~/bin/zsh-plugins'
alias zt='vim ~/bin/tmux/.tmux.conf'
alias zv='vim ~/.vim_runtime/my_configs.vim'
alias zvp='vim ~/.vim_runtime/vimrcs/plugins_config.vim'
alias zpp='vim ~/bin/project-specific/private.sh'
alias zz='vim ~/.zshrc'

#rails aliases
alias ss='rspec --color'
alias st='spring stop'
alias rake='bundle exec rake'

# function _rake_command () {
#   if [ -e "bin/rake" ]; then
#     bin/rake $@
#   elif type bundle &> /dev/null && [ -e "Gemfile" ]; then
#     bundle exec rake $@
#   else
#     command rake $@
#   fi
# }

# alias rake='_rake_command'
# compdef _rake_command=rake

alias devlog='lnav log/development.log'
alias prodlog='lnav log/production.log'
alias testlog='lnav log/test.log'

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'

# Rake aliases
alias rdm='rake db:migrate'
alias rdms='rake db:migrate:status'
alias rdr='rake db:rollback'
alias rdc='rake db:create'
alias rds='rake db:seed'
alias rdd='rake db:drop'
alias rdrs='rake db:reset'
alias rdtc='rake db:test:clone'
alias rdtp='rake db:test:prepare'
alias rdmtc='rake db:migrate db:test:clone'
alias rdsl='rake db:schema:load'
alias rlc='rake log:clear'
alias rn='rake notes'
alias rr='rake routes'
alias rrg='rake routes | grep'
alias rt='rake test'
alias rmd='rake middleware'
alias rsts='rake stats'

# legacy stuff
# alias sstat='thin --stats "/thin/stats" start'
# alias sg='ruby script/generate'
# alias sd='ruby script/destroy'
# alias sp='ruby script/plugin'
# alias sr='ruby script/runner'
# alias ssp='ruby script/spec'
# alias sc='ruby script/console'
# alias sd='ruby script/server --debugger'

function remote_console() {
  /usr/bin/env ssh $1 "( cd $2 && ruby script/console production )"
}

#source aliases
alias soa='source ~/bin/shell-config/bash_aliases.sh'

alias emberclean='rm -rf tmp node_modules bower_packages; npm cache_clean; bower cache clean; npm install; bower install'


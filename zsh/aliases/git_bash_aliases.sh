#git commands
alias ga='git add -p'               # stage changes with confirmation per-chunk
alias gaa='git add -A'              # stage all changes without confirmation
alias gan='git add -N'              # stage new git files
alias gc='git commit'               # commit changes
alias gcm='git commit -m'           # this allows me to use 'gcm "Commit message"'
alias gcn='git commit --no-edit'    # this allows me to use 'git commit' without asking to confirm message
alias gca='git commit --amend'      # override the last commit
alias gcan='git commit --amend --no-edit' # override the last commit without message confirmation
alias gl='git pull -r'   #always pull and rebase actuall branch

# this is super fancy git-tree logging mechanism try: glog <<branch>> or just glog
# alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n 15"
alias gmy='glog --author="Sebastian Wilgosz"' # log the tree of owned commits
alias gm='git merge --no-ff'                  # merge branch
alias go='git checkout'                       # checkout to the different branch
alias gp='git push'                           # always push actual branch.
alias gpf='git push --force-with-lease'       # safely force push to the current branch
alias gs='git status'                         # list changed files
alias gr='git rebase master'                  # I often rebase with master and almost never with other branches.
alias gbrm='git branch --merged | xargs git branch -D' #remove all merged branches
alias gri='git rebase -i'                     # interactive rebase
alias gra='git rebase --autostash'            # stash changes, rebase with master and pop bach the changes from the stash
alias gpruneall='git remote prune origin'     # remove legacy branches from origin
alias gremoveunused="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D"

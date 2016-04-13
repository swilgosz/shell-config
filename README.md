# shell-config

This is the config I use to work with web applications. Designed to make my terminal as productive as possible. This is tested and designed for iTerm2
terminal. 

## Installation

1. clone this repository `git clone https://github.com/wilgoszpl/shell-config.git ~/bin`
2. Add this line to your `~/.bash_profile` file

    ```shell
    source ~/bin/.source.sh
    ```
3. clone subprojects:
    
    ```shell
    git clone git@github.com:chriskempson/base16-shell.git ~/bin/base16-shell
    ```

    ```shell
    git clone git@github.com:chriskempson/base16-iterm2.git ~/bin/base16-iterm2
    ```
4. install [iterm2](https://www.iterm2.com/index.html)
5. install tmux 
    ```shell
    brew install tmux
    ```

## Script list

1. Git branch color
2. Git command autocomplete
3. Git aliases
4. Git rewrite author
5. Project specific script structurization
6. Shell color schemes
7. TMUX runtime script

### 1. Git branch color

If there is a git repository in current folder, it shows the current branch name, and color it to green/red depending of uncommitted changes

### 2. Git completion

Based on http://gitweb.hawaga.org.uk/ . This script autocompletes git commands after pressing <TAB> key.

### 3. Git aliases

I use several shortcuts for git to improve my speed of repository management. For now I didn't updated `git autocomplete script` to work with
aliases, so I use shell aliases only for commands without need to autocomplete branches.

``` shell
alias ga='git add -p'
alias gaa='git add -A'
alias gc='git commit -m' #this allows me to use 'gc "Commit message"'
alias gca='git commit --amend'
alias gl='git pull -r'   #always pull and rebase actuall branch
alias gm='git merge'
alias go='git checkout'
alias gp='git push'      #always push actual branch.
alias gs='git status'
alias gr='git rebase master' #I often rebase with master and almost never with other branches.
alias gri='git rebase -i'
```

### 4. Git rewrite author

This script is extracted from [This repository](https://github.com/davidfokkema/git-rewrite-author) just to keep things simple

### 5. Project specific scripts

If you want to add commands for project specific environment setup, just add `project-specific/private.sh` and list sources of private files there.

I name private project_files started from `_` - those files are also ingnored in this repository.

Example:

```shell
FILE: project-specific/private.sh

source $HOME/bin/project-specific/_wpl.sh
```

```shell
FILE project-specific/_wpl.sh

#HERE you can provide scripts to setup your project environment
#


wpl(){
  cd $HOME/Projects/wilgoszpl/source
  rvm use 2.3.0@wpl
}

wpls(){
  wpl
  RAILS_ENV=development rails s
}
```

This configuration allows me to simply use `wpls` to *immediately start* rails server inside of my project with proper gemset set. I use separeate file
for each project and keep them private.

### 7. Tmux runtime script

This script immediately opens terminal with two windows with 3 panels ond first one, runs vim, server, console, and prepare project-specific
environment.

To use it, just setup those environment variables. I place them inside of my project-specific files in `twpl` command. After configuring environment
in this way, typing `twpl` in your terminal will do everything you need - just start coding.


```shell
FILE project-specific/_wpl.sh

#HERE you can provide scripts to setup your project environment
#

#prepare project specific environment
wpl(){
  cd $HOME/Projects/wilgoszpl/source
  rvm use 2.3.0@wpl
}

#run server with project specific environment
wpls(){
  wpl
  RAILS_ENV=development rails s
}

#run tmux environment auto setup
twpl(){
  export prcmd=wpl
  export scmd=wpls
  export session=wilgoszpl
  export window1=${session}:shell
  export window2=${session}:vim
  ~/bin/.tmux/rails-dev.sh
}
```
##Contribution

1. Fork it
2. Create Pull request.


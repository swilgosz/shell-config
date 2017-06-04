# Base16 Shell
BASE16_SHELL="$HOME/bin/base16-shell/base16-monokai.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
export BASE16_SHELL

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

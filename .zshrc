export EDITOR="vim"

source $HOME/.config/zsh/bash_aliases.sh

if [ -f "$HOME/.config/zsh/project-specific/private.sh" ]
then
  source $HOME/.config/zsh/project-specific/private.sh
fi

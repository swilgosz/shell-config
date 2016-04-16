# in this file set all source files of your project-specific scripts
# i. e.: source $HOME/bin/project-specific/foo.sh

if [ -f "$HOME/bin/project-specific/private.sh" ]
then
  source $HOME/bin/project-specific/private.sh
fi

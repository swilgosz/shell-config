# This script shows custom color of current git branch in git repository folder
# and colors this branch name to red/green depending of uncommitted changes.

# Setting GIT prompt
c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

branch_color ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    color=""
    if git diff --quiet 2>/dev/null >&2
    then
      color=${c_green}
    else
      color=${c_red}
    fi
  else
    return 0
  fi
  echo -n $color
}

parse_git_branch ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gitver="["$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')"]"
  else
    return 0
  fi
  echo -e $gitver
}


#It's important to escape colors with \[ to indicate the length is 0
PS1='\u@\[${c_red}\]\W\[${c_sgr0}\]\[\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]$ '


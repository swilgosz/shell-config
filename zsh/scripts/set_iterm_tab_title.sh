#!/usr/bin/env zsh
# Set the current iTerm2 tab/pane title using escape sequences.
# Usage: set_iterm_tab_title.sh [title]
# Falls back to "claude" if no argument given.

title="${1:-claude}"

# Set tab title (iTerm2 escape sequence)
printf "\033]1;%s\007" "$title"
# Set window title as well
printf "\033]2;%s\007" "$title"

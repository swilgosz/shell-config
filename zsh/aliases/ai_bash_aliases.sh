alias ail="cd ~/SecondBrain/6.\ Spaces/60.\ Life && claude --enable-auto-mode"
alias aib="cd ~/SecondBrain/6.\ Spaces/62.\ Business && claude --enable-auto-mode"
alias aiw="cd ~/work && claude --add-dir ~/SecondBrain/6.\ Spaces/63.\ Work --enable-auto-mode"

alias aicso="cd /Users/sebastian/SecondBrain/6.\ Spaces/62.\ Business/620.\ Agents/cso"
alias aicoo="cd /Users/sebastian/SecondBrain/6.\ Spaces/62.\ Business/620.\ Agents/coo"
alias aicmo="cd /Users/sebastian/SecondBrain/6.\ Spaces/62.\ Business/620.\ Agents/cmo"
alias aiceo="cd /Users/sebastian/SecondBrain/6.\ Spaces/62.\ Business/620.\ Agents/ceo"
alias aigh="cd /Users/sebastian/SecondBrain/6.\ Spaces/62.\ Business/620.\ Agents/ghost"

claude-branch() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  local title="claude: ${branch:-no-git}"
  # Retry every 2s for 10s to reliably win the race against Claude Code's title setting
  (for _ in 1 2 3 4 5; do
    sleep 2
    python3 ~/Projects/shell-config/zsh/scripts/set_iterm_tab_title.py "$title" 2>/dev/null
  done) &!
  claude --enable-auto-mode "$@"
}
alias aic=claude-branch

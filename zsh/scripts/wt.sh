#!/usr/bin/env zsh
# Git worktree checkout — create or reuse a worktree
#
# Usage:
#   go               — list all worktrees
#   go <name>        — create or reuse worktree; branch defaults to feature/<name>
#   go feature/foo   — folder name: foo, branch: feature/foo
#   go <name> <branch> — explicit branch name
#
# Examples:
#   go coupon
#   go feature/coupon-system
#   go coupon feature/coupon-system
#   go main

set -e

BARE_ROOT="$(git worktree list | head -1 | awk '{print $1}')"

# No args — list worktrees
if [[ -z "$1" ]]; then
  git worktree list
  return 0 2>/dev/null || exit 0
fi

INPUT="$1"

# If input contains '/', use last segment as folder name and input as branch
if [[ "$INPUT" == */* ]]; then
  FOLDER="${INPUT##*/}"
  BRANCH="${2:-$INPUT}"
else
  FOLDER="$INPUT"
  BRANCH="${2:-feature/$INPUT}"
fi

WORKTREE="$BARE_ROOT/$FOLDER"

# Already exists — just cd into it
if git worktree list | grep -q "^$WORKTREE "; then
  echo "→ Worktree already exists: $WORKTREE"
  echo "  branch: $(git -C "$WORKTREE" branch --show-current)"
  cd "$WORKTREE"
  exec $SHELL
fi

# Branch exists locally or remotely — check out without -b
if git show-ref --verify --quiet "refs/heads/$BRANCH" || \
   git show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
  git worktree add "$WORKTREE" "$BRANCH"
else
  git worktree add "$WORKTREE" -b "$BRANCH"
fi

# Copy .env.local from main if not present
MAIN="$BARE_ROOT/main"
if [[ -f "$MAIN/.env.local" && ! -f "$WORKTREE/.env.local" ]]; then
  cp "$MAIN/.env.local" "$WORKTREE/.env.local"
  echo "  ✓ Copied .env.local from main"
fi

# Symlink node_modules from main if not present
if [[ -d "$MAIN/node_modules" && ! -e "$WORKTREE/node_modules" ]]; then
  ln -s "$MAIN/node_modules" "$WORKTREE/node_modules"
  echo "  ✓ Symlinked node_modules from main"
fi

echo "→ Worktree ready: $WORKTREE"
echo "  branch: $BRANCH"
cd "$WORKTREE"
exec $SHELL

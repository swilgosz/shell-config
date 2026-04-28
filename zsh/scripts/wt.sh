#!/usr/bin/env zsh
# Git worktree checkout — create or reuse a worktree
#
# Usage:
#   go               — list all worktrees
#   go <name>        — create or reuse worktree; branch defaults to feature/<name>
#   go feature/foo   — folder name: foo, branch: feature/foo
#   go <name> <branch> — explicit branch name
#   go <tag>         — detached HEAD at tag (auto-fetches if missing)
#
# Examples:
#   go coupon
#   go feature/coupon-system
#   go coupon feature/coupon-system
#   go main
#   go cba-v1.20260422.1            # detached at tag
#   go cba-v1.20260422.1 hotfix/x   # hotfix branch based off the tag

set -e

BARE_ROOT="$(git worktree list | head -1 | awk '{print $1}')"

# No args — list worktrees
if [[ -z "$1" ]]; then
  git worktree list
  return 0 2>/dev/null || exit 0
fi

INPUT="$1"
IS_TAG=false
BASE=""

resolve_tag() {
  git show-ref --verify --quiet "refs/tags/$1"
}

# If input contains '/', use last segment as folder name and input as branch
if [[ "$INPUT" == */* ]]; then
  FOLDER="${INPUT##*/}"
  BRANCH="${2:-$INPUT}"
elif [[ -n "$2" ]]; then
  FOLDER="$INPUT"
  BRANCH="$2"
  # If $1 is a tag, the new branch should be based off the tag
  if resolve_tag "$INPUT" || { git fetch --tags --quiet 2>/dev/null; resolve_tag "$INPUT"; }; then
    BASE="refs/tags/$INPUT"
  fi
elif git show-ref --verify --quiet "refs/heads/$INPUT" || \
     git show-ref --verify --quiet "refs/remotes/origin/$INPUT"; then
  # Existing branch matches input (e.g. master, develop) — reuse it, don't prefix feature/
  FOLDER="$INPUT"
  BRANCH="$INPUT"
elif resolve_tag "$INPUT"; then
  FOLDER="$INPUT"
  IS_TAG=true
else
  # Not a local branch or tag — try fetching tags before falling through to feature/
  git fetch --tags --quiet 2>/dev/null || true
  if resolve_tag "$INPUT"; then
    FOLDER="$INPUT"
    IS_TAG=true
  else
    FOLDER="$INPUT"
    BRANCH="feature/$INPUT"
  fi
fi

WORKTREE="$BARE_ROOT/$FOLDER"

# Already exists — just cd into it
if git worktree list | grep -q "^$WORKTREE "; then
  echo "→ Worktree already exists: $WORKTREE"
  CURRENT="$(git -C "$WORKTREE" branch --show-current 2>/dev/null)"
  if [[ -n "$CURRENT" ]]; then
    echo "  branch: $CURRENT"
  else
    echo "  detached: $(git -C "$WORKTREE" describe --tags --always 2>/dev/null)"
  fi
  cd "$WORKTREE"
  exec $SHELL
fi

# Create worktree
if [[ "$IS_TAG" == true ]]; then
  git worktree add --detach "$WORKTREE" "refs/tags/$INPUT"
elif [[ -n "$BASE" ]]; then
  # New branch based off a tag
  git worktree add "$WORKTREE" -b "$BRANCH" "$BASE"
elif git show-ref --verify --quiet "refs/heads/$BRANCH" || \
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

if [[ "$IS_TAG" == true ]]; then
  echo "→ Worktree ready (detached at tag): $WORKTREE"
  echo "  tag:    $INPUT"
  echo "  hint:   to patch, run: git checkout -b hotfix/<name>"
elif [[ -n "$BASE" ]]; then
  echo "→ Worktree ready: $WORKTREE"
  echo "  branch: $BRANCH (based off $INPUT)"
else
  echo "→ Worktree ready: $WORKTREE"
  echo "  branch: $BRANCH"
fi
cd "$WORKTREE"
exec $SHELL

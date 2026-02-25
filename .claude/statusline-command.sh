#!/bin/sh
# Claude Code status line - inspired by af-magic zsh theme

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Resolve git branch (skip optional locks)
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# ANSI colors matching af-magic palette
DARK_GRAY=$(printf '\033[38;5;237m')
BLUE=$(printf '\033[38;5;32m')
GREEN=$(printf '\033[38;5;78m')
CYAN=$(printf '\033[38;5;75m')
PURPLE=$(printf '\033[38;5;105m')
ORANGE=$(printf '\033[38;5;214m')
RESET=$(printf '\033[0m')

# user@host
user_host="$(whoami)@$(hostname -s)"

# directory: show path
dir_display="$cwd"

# git info
if [ -n "$git_branch" ]; then
  git_info=" ${CYAN}(${GREEN}${git_branch}${CYAN})${RESET}"
else
  git_info=""
fi

# context usage
if [ -n "$used" ]; then
  ctx_info=" ${DARK_GRAY}ctx:${used}%${RESET}"
else
  ctx_info=""
fi

# model info
if [ -n "$model" ]; then
  model_info=" ${PURPLE}[${model}]${RESET}"
else
  model_info=""
fi

printf "${DARK_GRAY}%s${RESET} ${BLUE}%s${RESET}%s%s%s" \
  "$user_host" \
  "$dir_display" \
  "$git_info" \
  "$ctx_info" \
  "$model_info"

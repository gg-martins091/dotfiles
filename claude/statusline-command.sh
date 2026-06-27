#!/usr/bin/env bash
# Claude Code status line — based on robbyrussell Oh My Zsh theme

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Colors (ANSI)
reset="\033[0m"
bold_green="\033[1;32m"
cyan="\033[0;36m"
bold_blue="\033[1;34m"
red="\033[0;31m"
yellow="\033[0;33m"

# Current dir (basename)
dir=$(basename "$cwd")

# Git info (skip optional locks)
git_branch=""
git_dirty=""
if git_dir=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --git-dir 2>/dev/null); then
  git_branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  if ! GIT_OPTIONAL_LOCKS=0 git -C "$cwd" diff --quiet 2>/dev/null || ! GIT_OPTIONAL_LOCKS=0 git -C "$cwd" diff --cached --quiet 2>/dev/null; then
    git_dirty=" ✗"
  fi
fi

# Context usage
ctx_info=""
if [ -n "$used" ] && [ "$used" != "null" ]; then
  used_int=${used%.*}
  ctx_info=" | ctx: ${used_int}%"
fi

# Model info
model_info=""
if [ -n "$model" ] && [ "$model" != "null" ]; then
  model_info=" | ${model}"
fi

# Build prompt
if [ -n "$git_branch" ]; then
  printf "${bold_green}➜${reset}  ${cyan}%s${reset} ${bold_blue}git:(${red}%s${bold_blue})${reset}${yellow}%s${reset}${model_info}${ctx_info}" \
    "$dir" "$git_branch" "$git_dirty"
else
  printf "${bold_green}➜${reset}  ${cyan}%s${reset}${model_info}${ctx_info}" "$dir"
fi

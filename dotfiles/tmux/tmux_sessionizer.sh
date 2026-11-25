#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    search_paths="fd --hidden --no-require-git -E node-modules -E .cargo -E .rustup -E .nvm -E .npm -E .cache -E .vscode --type directory --color never --max-depth 5 . $HOME"
    selected=$(fzf --tmux --bind "start:reload:$search_paths")
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name

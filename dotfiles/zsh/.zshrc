HISTFILE=$XDG_STATE_HOME/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt prompt_subst
unsetopt autocd beep extendedglob nomatch
bindkey -v
autoload -U colors && colors

# ls colors on autocomplete
eval "$(dircolors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Caseless autocomplete
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

autoload -Uz compinit
if [[ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' "$ZDOTDIR/.zcompdump" 2>/dev/null)" ]]; then
    compinit
else
    compinit -C
fi

git_ps1 () {
    local branch_name
    local is_modified_status=""

    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
        is_modified_status="*"
    fi

    branch_name=$(git branch --no-color 2>/dev/null | sed -E -n 's/^\* (.*)/\1/p')
    if [[ -n "${branch_name}" ]]; then
        if [[ "${is_modified_status}" == "*" ]]; then
            echo " %F{red}(${branch_name}${is_modified_status})%f"
        else
            echo " %F{green}(${branch_name}${is_modified_status})%f"
        fi
    else
        echo ""
    fi
}

PROMPT='%F{#98971a}%~%f$(git_ps1) %F{#458588}λ%f '

if [[ -f "$XDG_CONFIG_HOME/zsh/.aliases" ]]; then
    source "$XDG_CONFIG_HOME/zsh/.aliases"
fi

FD_OPTIONS="--follow --exclude .git --exclude node_modules --no-hidden"
export FZF_DEFAULT_OPTS=''
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMAMND="fd --type d $FD_OPTIONS"
source <(fzf --zsh)

# fnm
FNM_PATH="${HOME}/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

if [[ -f "${HOME}"/.local/bin/check_dotfiles_update.sh ]]; then
    "${HOME}"/.local/bin/check_dotfiles_update.sh
fi

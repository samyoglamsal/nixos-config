#!/usr/bin/env bash

# This script symlinks the config files located here to $XDG_CONFIG_HOME
#
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${script_dir}"

if [[ -z "${XDG_CONFIG_HOME}" ]]; then
    echo "XDG_CONFIG_HOME environment variable is not set, defaulting to ${HOME}/.config"
    XDG_CONFIG_HOME="${HOME}/.config"
fi

for dir in */; do
    dir="${dir%/}"
    
    if [[ "${dir}" == ".git" ]]; then
        continue 
    elif [[ -d "${XDG_CONFIG_HOME}/${dir}" ]]; then
        echo "${dir} already exists in ${XDG_CONFIG_HOME}, please remove the existing directory if you'd like to use this script"
    else
        echo "Creating soft link for ${dir} in ${XDG_CONFIG_HOME}"
        ln -s "${script_dir}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
    fi
done

if [[ ! -e "$HOME/.local/bin/check_dotfiles_update.sh" ]]; then
    echo "Creating soft link for update checking script..."
    ln -s "${script_dir}/check_dotfiles_update.sh" "$HOME/.local/bin/check_dotfiles_update.sh"
fi

echo "Done"

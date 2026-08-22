#!/usr/bin/env bash

# This file will watch for any changes in waybar's config, and then reload waybar to reflect the changes

while read line
do
    killall -SIGUSR2 waybar
done < <(inotifywait -q -m -e modify "$HOME/.config/waybar/")

#!/usr/bin/env bash
# Prints used memory in GiB (MemTotal minus MemAvailable), one decimal place.
awk '/MemTotal/ {t = $2} /MemAvailable/ {a = $2} END {printf "%.1f", (t - a) / 1048576}' /proc/meminfo

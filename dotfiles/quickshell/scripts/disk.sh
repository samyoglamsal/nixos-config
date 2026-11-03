#!/usr/bin/env bash
# Prints "busy_ms sectors_written" for the OS disk; the QML side computes busy % and MB/s from deltas.
DEV=sda  # the disk that holds the root filesystem
awk -v d="$DEV" '$3 == d {print $13, $10}' /proc/diskstats

#!/usr/bin/env bash
# Prints "idle total" jiffies from /proc/stat; the QML side computes the percentage from deltas.
awk '/^cpu /{idle = $5 + $6; total = 0; for (i = 2; i <= NF; i++) total += $i; print idle, total}' /proc/stat

#!/usr/bin/env bash

# This script checks to see if the remote is on a newer commit than the local

script_dir="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
cd "${script_dir}"

git fetch --quiet origin main

remote_commit=$(git rev-parse origin/main)

if ! git merge-base --is-ancestor "$remote_commit" HEAD; then
    echo "Dotfile updates are available"
fi

#!/usr/bin/env sh

if [ -d .git ]; then
   echo " (commit: $(git log -n 1 --pretty=%H))"
fi

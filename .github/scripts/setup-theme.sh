#!/usr/bin/env bash

python3 -m venv ~/.venv
source ~/.venv/bin/activate
python -m pip install konsave

function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dotfiles pull
dotfiles reset --hard

konsave -a $THEME               # Konsave theme
fc-cache -f -v                  # refresh fonts
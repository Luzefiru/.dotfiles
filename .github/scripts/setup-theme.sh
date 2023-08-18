#!/usr/bin/env bash
THEME=dev # change this to the Konsave theme you want

python3 -m venv ~/.venv
source ~/.venv/bin/activate
python -m pip install konsave

function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dotfiles pull
dotfiles reset --hard

konsave -a $THEME               # Konsave theme
konsave -s backup               # Backs up previous setup to a Konsave profile
fc-cache -f -v                  # refresh fonts

#!/usr/bin/env bash
THEME=dev # TODO: make prompt to select Konsave theme until user inputs a valid theme

echo
echo "SETTING UP KDE DESKTOP THEME"
echo

dotfiles reset --hard

source ~/.venv/bin/activate
konsave -a dev
konsave -a $THEME               # Konsave theme
fc-cache -f -v                  # refresh fonts

rm -f index.sh setup-dotfiles.sh install.sh

echo
echo "Done! Reboot your computer to finalize the changes."
echo

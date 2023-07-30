#!/usr/bin/bash
GITHUB_REPO_URL=https://github.com/Luzefiru/.dotfiles.git # change this to the $GITHUB_REPO_URL you used earlier
BRANCH=main

echo
echo "[5.1] Cloning the $BRANCH branch of $GITHUB_REPO_URL"
echo

cd $HOME
git clone --bare --branch $BRANCH $GITHUB_REPO_URL $HOME/.dotfiles
 
function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

echo
echo "[5.2] Creating backups of your old dotfiles to $HOME/.dotfiles-backup"
echo

 
mkdir -p .dotfiles-backup && echo && echo "Created $HOME/.dotfiles-backup."
dotfiles checkout && echo "Checking out $BRANCH."
 
if [ $? = 0 ]; then
  echo "Checked out .dotfiles.";
  else
    echo "Backing up pre-existing dot files into .dotfiles-backup/.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
 
dotfiles checkout && echo "Checking out $BRANCH."
dotfiles config status.showUntrackedFiles no && echo "Backup completed."

echo
echo "[5.3] Creating aliases to your .zshrc and .bashrc files."
echo

# creates the dotfiles alias to use the git system
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc && echo "Successfully created alias dotfiles in $HOME/.bashrc"
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc && echo "Successfully created alias dotfiles in $HOME/.zshrc"

# TODO: fix problematic code and enable smooth transition to zsh at end of script
source .bashrc
source .zshrc   # will fail because we haven't installed oh-my-zsh and p10k yet, need to reboot

# Setting Up A Dotfiles Repository
 
This ia a guide tailor made to create a custom dotfiles repository.

# Table of Contents

- [Setting Up .dotfiles](https://github.com/Luzefiru/.dotfiles/tree/main#setting-up-dotfiles)
   - [Creating a New Remote Repository](https://github.com/Luzefiru/.dotfiles/tree/main#creating-a-new-remote-repository)
   - [Installation On New Machines](https://github.com/Luzefiru/.dotfiles/tree/main#installation-on-new-machines)
   - [Wrap Up](https://github.com/Luzefiru/.dotfiles/tree/main#wrap-up)
- [Installing Packages](https://github.com/Luzefiru/.dotfiles/tree/main#installing-packages)
- [Resources](https://github.com/Luzefiru/.dotfiles/tree/main#resources)

# Setting Up .dotfiles

This section focuses on setting up and pushing to a remote a `~/.dotfiles/` repository along with how to pull from it with a fresh machine.
 
## Creating a New Remote Repository
 
We create add a `dotfiles` alias to `.bashrc` and `.zshrc` to allow us to use `/usr/bin/git` with our target `--git-dir` and `--work-tree`.
 
> Note: the `$HOME/.dotfiles` directory will contain the [Git Bare Repository](https://stackoverflow.com/questions/5540883/whats-the-practical-difference-between-a-bare-and-non-bare-repository).
 
```bash
$ bash
$ git init --bare $HOME/.dotfiles
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ dotfiles config --local status.showUntrackedFiles no
$ echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```
 
After running the commands above, you can use the `dotfiles` alias as if it was the `git` command, but scoped to its own directory and Working Tree like so:
 
```bash
$ dotfiles status
$ dotfiles add ~/.bashrc
$ dotfiles commit -m "add .bashrc"
$ dotfiles remote add $GITHUB_REPO_URL
$ dotfiles push
```

Note: the `$GITHUB_REPO_URL` is the repository you want to push your configuration files to.
 
## Installation On New Machines
 
We create a [Bash Script](https://devhints.io/bash) to automatically clone this repository, create a backup of the previous dot files (if there are any conflics), and checkout the bare repository to load the files into the system.
 
```bash
$ cd ~
$ touch dotfiles.sh
$ chmod +x dotfiles.sh
$ nano dotfiles.sh
```
 
These are the contents of the `dotfiles.sh`, copy paste it into the `nano` window and save changes with `CTRL+X`, `Y`, and `ENTER`.

> Note: this script will checkout the code specified in the `GITHUB_REPO_URL` with a specific `--branch <name>`. You may change the `--branch <name>` to the branch where your desired dotfiles are in the specified `$GITHUB_REPO_URL` [from the previous section](https://github.com/Luzefiru/.dotfiles/tree/main#starting-from-scratch).
 
```bash
#!/usr/bin/bash
GITHUB_REPO_URL=https://github.com/Luzefiru/.dotfiles.git # change this to the $GITHUB_REPO_URL you used earlier
BRANCH=main # change this to a branch you want to check out and copy into `~/`.

git clone --bare --branch $BRANCH $GITHUB_REPO_URL $HOME/.dotfiles
 
function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
 
mkdir -p .dotfiles-backup
dotfiles checkout
 
if [ $? = 0 ]; then
  echo "Checked out .dotfiles.";
  else
    echo "Backing up pre-existing dot files into .dotfiles-backup/.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
 
dotfiles checkout
dotfiles config status.showUntrackedFiles no

echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```
 
Finally, we run the newly created script then source our `rc` configs to get the `dotfiles` command.
 
```bash
$ ./dotfiles.sh
$ source .zshrc
$ source .bashrc
```

## Wrap Up

If you followed all the steps properly and your `$HOME` is the same as your new machine, you should be able to use the `dotfiles` alias once the script above is run.

> Note: `fatal: not a git repository: '/home/user/.dotfiles/'`, means your previous `$HOME` does not match the new machine, so we need to rebind the `alias dotfiles` via the commands below.
 
```bash
$ unalias dotfiles
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

$ dotfiles status
$ dotfiles add .vimrc
$ dotfiles commit -m "add .kde"
$ dotfiles push
```

# Resources
 
- [Dotfiles: Best Way to Store in a Bare Git Repository](https://www.atlassian.com/git/tutorials/dotfiles)

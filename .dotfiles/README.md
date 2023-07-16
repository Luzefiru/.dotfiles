# .dotfiles
 
My backed up configurations for my ~/.dotfiles, along with a setup guide.
 
# Starting From Scratch
 
We create add a `dotfiles` alias to `.bashrc` and `.zshrc` to allow us to use `/usr/bin/git` with our target `--git-dir` and `--work-tree`.
 
Note: the `$HOME/.dotfiles` directory will contain the [Git Bare Repository](https://stackoverflow.com/questions/5540883/whats-the-practical-difference-between-a-bare-and-non-bare-repository).
 
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
$ dotfiles push
```
 
# Installing the `.dotfiles`
 
We create a [Bash Script](https://devhints.io/bash) to automatically clone this repository, create a backup of the previous dot files (if there are any conflics), then checks out the bare repository to load the files into the system.
 
```bash
$ cd ~
$ touch dotfiles.sh
$ chmod +x dotfiles.sh
$ nano dotfiles.sh
```
 
These are the contents of the `dotfiles.sh`, copy paste it into the `nano` window and save changes with `CTRL+X`, `Y`, and `ENTER`.
 
```bash
#!/usr/bin/bash
git clone --bare https://github.com/Luzefiru/.dotfiles.git $HOME/.dotfiles
 
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
```
 
Finally, we run the newly created script.
 
```bash
$ ./dotfiles.sh
```
 
We should be able to use the `dotfiles` alias once the script above is run.
 
```bash
$ dotfiles status
$ dotfiles add .vimrc
$ dotfiles commit -m "add .kde"
$ dotfiles push
```
 
# Resources
 
- [Dotfiles: Best Way to Store in a Bare Git Repository](https://www.atlassian.com/git/tutorials/dotfiles)

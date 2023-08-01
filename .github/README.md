# .dotfiles
 
A remote backup repository containing my `~/.dotfiles`, along with a guide to spin up my development environment in any machine.

# Table of Contents

- [TODO](https://github.com/Luzefiru/.dotfiles/tree/main#todo)
- [Installation](https://github.com/Luzefiru/.dotfiles/tree/main#installation)
- [Troubleshooting](https://github.com/Luzefiru/.dotfiles/tree/main#troubleshooting)

# TODO

- [ ] Rice my Kubuntu.
- [ ] Create `pkglist.txt` and create a more descriptive install script.
- [ ] Split script into knowledge domains and composite them into 1 script.

# Installation

The main branch was made to bootstrap myself whenever I create a new Kubuntu machine.

Running the script will sync my machine with the remote repository and allow me to use [Konsave](https://github.com/Prayag2/konsave) to import and use any profile from the `~/.config/konsave/profiles/<profile>/<profile>.knsv` file.

```bash
$ cd ~
$ curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/install.sh
$ sudo chmod u+x ./install.sh
$ ./install.sh
$ reboot # to enable configs
```

# Troubleshooting
 
- [Dotfiles: Best Way to Store in a Bare Git Repository](https://www.atlassian.com/git/tutorials/dotfiles)

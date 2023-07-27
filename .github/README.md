# Arch

These are my `~/.dotfiles/` for my Arch Linux machines installed with `systemd` using the `archinstall` script.

# Setup

When you run the `dotfiles.sh` script specified in [this section](https://github.com/Luzefiru/.dotfiles#installing-the-dotfiles) of the `main` branch and setting the script to pull from the `arch` branch, you'll be left with the base configuration files for various applications.

These are essential services that need to be configured on fresh `archinstall` installations.

```bash
$ systemctl enable --now iwd
$ systemctl enable --now systemd-networkd
$ systemctl enable --now systemd-resolved
$ systemctl enable --now dchpcd
```

# Applications

The applications still need to be installed in order to use their configurations, so try to follow the list below.

## Services

- bspwm (window manager)
- dhcpcd (DHCP network manager)
- sxhkd (hotkey daemon)
- picom (compositor)
- nitrogen (wallpaper management)

## Utilities

- yay
- code
- zsh
- oh-my-zsh

## Development

- git
- code

## Applications

- firefox

## Miscellaneous

- neofetch
- powerlevel10k
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
$ systemctl --user enable --now pipewire.socket
$ systemctl --user enable --now pipewire-pulse.socket
$ systemctl --user enable --now wireplumber.service
```

# Applications

```
alacritty
base
base-devel
bspwm
code
dhcpcd
dmenu
efibootmgr
firefox
git
htop
intel-media-driver
intel-ucode
iwd
libva-intel-driver
lightdm
lightdm-gtk-greeter
linux
linux-firmware
mesa
nano
neofetch
nitrogen
ntfs-3g
pavucontrol
picom
pipewire
pipewire-alsa
pipewire-jack
pipewire-pulse
polybar
rsync
smartmontools
sxhkd
vim
vulkan-intel
wget
wireless_tools
wireplumber
wpa_supplicant
xdg-utils
xdo
xorg-server
xorg-xinit
zram-generator
zsh
```

These packages are not official packages and need to be installed manually from the AUR or via `yay`.

```
ttf-meslo-nerd-font-powerlevel10k
yay
```
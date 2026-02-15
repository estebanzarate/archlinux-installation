# Arch Linux Installation

<img width="600" height="199" alt="archlinux-logo-light-90dpi" src="https://github.com/user-attachments/assets/4a251114-a303-493b-80aa-6089db3cc82d" />

## Tools

- `base-devel`
- `firefox` (option 10 ttf-dejavu)
- `ffuf`
- `git`
- `hashcat`
- `hydra`
- `kitty`
- `neovim`
- [NvChad](https://nvchad.com/docs/quickstart/install/)
- `openbsd-netcat`
- `openvpn`
- `polybar`
- `rust`
- `type`
- `virtualbox-guest-utils`
- `xclip`
- `xorg-xset`

```bash
sudo pacman -S base-devel firefox git hashcat hydra kitty neovim openbsd-netcat openvpn polybar rust virtualbox-guest-utils xclip xorg-xset
```

```bash
sudo systemctl enable --now vboxservice
```

```bash
mkdir -p $HOME/.config/{bspwm,kitty,nvim,polybar,sxhkd}
mkdir $HOME/.config/polybar/scripts
touch $HOME/.config/polybar/scripts/{target.sh,target.txt,vpn.sh,}
chmod +x $HOME/.config/polybar/scripts/{target.sh,vpn.sh}
```

```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
```

```bash
paru -S arc-gtk-theme burpsuite ffuf
```

`/etc/lightdm/lightdm-gtk-greeter.conf`

```bash
[greeter]
#background=
#user-background=
theme-name=Arc-Dark
```

Repos

- [SecLists](https://github.com/danielmiessler/SecLists.git)

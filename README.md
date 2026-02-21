# Arch Linux Installation

<img width="600" height="199" alt="archlinux-logo-light-90dpi" src="https://github.com/user-attachments/assets/4a251114-a303-493b-80aa-6089db3cc82d" />

```bash
loadkeys la-latin1
setfont ter-120b
pacman -Sy archinstall
archinstall
```

- **Archinstall language**: `English`
- **Locales**:
  - **Keyboard layout**: `la-latin1`
- **Mirrors and repositories**:
  - **Select regions**: `Brazil`

## Tools

- `aws-cli-v2`
- `base-devel`
- `bat`
- `binutils`
- `firefox` (option 10 ttf-dejavu)
- `ffuf`
- `git`
- `hashcat`
- `hydra`
- `impacket`
- `john`
- `kitty`
- `less`
- `neovim`
- `netexec`
- `nmap`
- [NvChad](https://nvchad.com/docs/quickstart/install/)
- `openbsd-netcat`
- `openvpn`
- `perl-image-exiftool`
- `pocl`
- `polybar`
- `radare2`
- `rust`
- `smbclient`
- `type`
- `unzip`
- `virtualbox-guest-utils`
- `wpscan`
- `xclip`
- `xorg-xset`

```bash
sudo pacman -S aws-cli-v2 base-devel bat binutils firefox git hashcat hydra impacket kitty less neovim nmap openbsd-netcat openvpn perl-image-exiftool pocl polybar radare2 rust smbclient unzip virtualbox-guest-utils wpscan xclip xorg-xset
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
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
```

```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
```

```bash
paru -S arc-gtk-theme burpsuite ffuf netexec
```

`/etc/lightdm/lightdm-gtk-greeter.conf`

```bash
[greeter]
#background=
#user-background=
theme-name=Arc-Dark
```

### John The Ripper

```bash
git clone https://github.com/openwall/john.git
cd john
./configure && make
cd ..
sudo mv john /opt
```

## Repos

- [SecLists](https://github.com/danielmiessler/SecLists.git)

## Others config

### Firefox

- `about:config`
- `browser.fixup.domainsuffixwhitelist.htb`, `browser.fixup.domainsuffixwhitelist.thm`
- `true`

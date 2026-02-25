# Arch Linux Installation

<img width="600" height="199" alt="archlinux-logo-light-90dpi" src="https://github.com/user-attachments/assets/4a251114-a303-493b-80aa-6089db3cc82d" />

Create a new machine in VirtualBox

<img width="424" height="231" alt="clipboard" src="https://github.com/user-attachments/assets/b8fa927f-f2ee-4778-b21e-1da4860ab3fd" />

After create VM

<img width="477" height="461" alt="boot" src="https://github.com/user-attachments/assets/04eea94b-0ab1-4d39-bd19-a9320e3b0dd8" />

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
- **Disk configuration**:
  - **Partitioning**:
    - **Use a best-effort default partition layout**: `ATA VBOX HARDDISK`
      - **Filesystem**: `ext4`
- **Authentication**:
  - **User account**: `Add a user`
    - **Should "user" be a superuser (sudo)?**: `yes`
  - **Confirm and exit**
- **Profile**:
  - **Type**:
    - **Desktop**: `Bspwm` (It'll install: `bspwm`, `dmenu`, `rxvt-unicode`, `sxhkd`, `xdo`)
  - **Graphics driver**: `VirtualBox (open-source)` (It'll install: `mesa`, `xorg-server`, `xorg-xinit`)
- **Applications**:
  - **Audio**: `pipewire`
- **Network configuration**: `Copy ISO network configuration to installation`
- **Timezone**: `America/Argentina/Buenos_Aires`
- **Install**
- **Exit archinstall**
- `poweroff`

Right click on the new VM created, select `settings`
- **General**:
  - **Features**:
    - **Shared Clipboard**: `Bidirectional`
- **System**:
  - **Boot Device Order (BIOS only)**:
    - Hard Disk [1]
    - Unselect `Floppy` and `Optical`
- **Storage**:
  - **Controller: IDE**:
    - Right click on `archlinux.iso`
      - Remove attachment
- **Network Attached to**: `Bridged Adapter`
- Click OK to finish

## Tools

-  `aws-cli-v2`
- `base-devel`
- `bat`
- `binutils`
- `cmake`
- `firefox` (option 10 ttf-dejavu)
- `ffuf`
- `git`
- `gtk3`
- `hashcat`
- `hydra`
- `impacket`
- `jadx`
- `john`
- `kitty`
- `less`
- `medusa`
- `metasploit`
- `neovim`
- `netexec`
- `nmap`
- [NvChad](https://nvchad.com/docs/quickstart/install/)
- `openbsd-netcat`
- `openvpn`
- `perl-image-exiftool`
- `picom`
- `pocl`
- `polybar`
- `p7zip`
- `qt5ct`
- `radare2`
- `rust`
- `smbclient`
- `tcpdump`
- `tree`
- `type`
- `unzip`
- `virtualbox-guest-utils`
- `wireshark-qt`
- `wpscan`
- `xclip`
- `xorg-xset`

```bash
sudo pacman -S aws-cli-v2 base-devel bat binutils cmake firefox git gtk3 hashcat hydra impacket jadx kitty less medusa metasploit neovim nmap openbsd-netcat openvpn p7zip perl-image-exiftool picom pocl polybar qt5ct radare2 rust smbclient tcpdump tree unzip virtualbox-guest-utils wireshark-qt wpscan xclip xorg-xset
```

```bash
sudo systemctl enable --now vboxservice
```

```bash
mkdir -p $HOME/.config/{bspwm,kitty,nvim,polybar,sxhkd,picom}
mkdir $HOME/.config/bspwm/scripts
mkdir $HOME/.config/polybar/scripts
touch $HOME/.config/polybar/scripts/{target.sh,target.txt,vpn.sh,}
touch $HOME/.config/bspwm/scripts/bspwm_resize
touch $HOME/.config/picom.conf
chmod +x $HOME/.config/polybar/scripts/{target.sh,vpn.sh}
chmod +x $HOME/.config/bspwm/scripts/bspwm_resize
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

### Wireshark

`$HOME/.xprofile`

```bash
export GTK_THEME=Arc-Dark
export GTK2_RC_FILES=/usr/share/themes/Arc-Dark/gtk-2.0/gtkrc
export QT_QPA_PLATFORMTHEME=gtk3
```

`$HOME/.config/gtk-3.0/settings.ini`

```bash
[Settings]
gtk-theme-name=Arc-Dark
gtk-application-prefer-dark-theme=true
```

```bash
sudo usermod -aG wireshark $USER
```

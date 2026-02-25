# Arch Linux Installation

<img width="600" height="199" alt="archlinux-logo-light-90dpi" src="https://github.com/user-attachments/assets/4a251114-a303-493b-80aa-6089db3cc82d" />

Create a new machine in VirtualBox

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
- `pocl`
- `polybar`
- `p7zip`
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
sudo pacman -S aws-cli-v2 base-devel bat binutils cmake firefox git hashcat hydra impacket jadx kitty less medusa metasploit neovim nmap openbsd-netcat openvpn p7zip perl-image-exiftool pocl polybar radare2 rust smbclient tcpdump tree unzip virtualbox-guest-utils wireshark-qt wpscan xclip xorg-xset
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

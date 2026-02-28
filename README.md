# Arch Linux Installation

<img width="600" height="199" alt="archlinux-logo-light-90dpi" src="https://github.com/user-attachments/assets/4a251114-a303-493b-80aa-6089db3cc82d" />

- Create a new VM in VirtualBox
- Right click on the new VM created, select `settings`

<img width="424" height="231" alt="clipboard" src="https://github.com/user-attachments/assets/b8fa927f-f2ee-4778-b21e-1da4860ab3fd" /><br>
<img width="310" height="311" alt="video" src="https://github.com/user-attachments/assets/8b69117c-929a-4dd3-90f4-3446dcfe9db4" /><br>

- Click OK to save settings

- Start VM

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
        - **Would you like to create a separate partition for /home?**: `No`
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
- **Install**:
  - **The specified configuration will be applied. Would you like to continue?**: `Yes`
- **Exit archinstall**
- `poweroff`

- Right click on the new VM created, select `settings`

<img width="477" height="461" alt="boot" src="https://github.com/user-attachments/assets/04eea94b-0ab1-4d39-bd19-a9320e3b0dd8" /><br>
<img width="475" height="329" alt="storage" src="https://github.com/user-attachments/assets/3dd10781-f38e-4eab-a309-88ed5b917061" /><br>

- Click OK to save settings

- Start VM
- Login with credentials 
- Press `ctrl` + `alt` + `F2` to open a new console

<img width="266" height="83" alt="login" src="https://github.com/user-attachments/assets/d964f004-87f0-498f-97f8-1f10b5fbe480" />

- Login with credentials AGAIN

```bash
mkdir -p ~/.config/{bspwm,sxhkd}
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
sudo pacman -S kitty virtualbox-guest-utils
sudo systemctl enable --now vboxservice
```

Add `pkill -x VBoxClient; sleep 1 && VBoxClient-all &` to `$HOME/.config/bspwm/bspwmrc`

Modify `terminal emulator` in `$HOME/.config/sxhkd/sxhkdrc` to `/usr/bin/kitty`

```bash
# terminal emulator
super + Return
  /usr/bin/kitty
```

- Reboot
- Login with credentials
- Press `super` + `Return` to open `kitty`

**NOW YOU CAN COPY AND PASTE**

```bash
sudo pacman -S aws-cli-v2 base-devel bat binutils cmake firefox fping git gtk3 hashcat hydra impacket jadx less medusa metasploit neovim nmap nodejs npm openbsd-netcat openldap openvpn p7zip perl-image-exiftool picom pocl polybar proxychains-ng qt5ct radare2 rust smbclient socat sqlmap tcpdump tor torbrowser-launcher tree ttf-hack-nerd unzip wireshark-qt wpscan xclip xorg-xset
# Providers: ttf-dejavu, jre21-openjdk, qt6-multimedia-ffmpeg
```

```bash
mkdir -p $HOME/.config/{kitty,nvim,polybar,picom,colors}
mkdir $HOME/.config/bspwm/scripts
mkdir $HOME/.config/polybar/scripts
touch $HOME/.config/polybar/scripts/{target.sh,target.txt,vpn.sh,}
touch $HOME/.config/bspwm/scripts/bspwm_resize
touch $HOME/.config/polybar/{launch.sh,env.sh}
touch $HOME/.config/colors/{colors.ini,colors.sh,colors.py}
chmod +x $HOME/.config/polybar/launch.sh
touch $HOME/.config/kitty/kitty.conf
touch $HOME/.config/picom/picom.conf
chmod +x $HOME/.config/polybar/scripts/{target.sh,vpn.sh}
chmod +x $HOME/.config/bspwm/scripts/bspwm_resize
```

```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
```

```bash
paru -S arc-gtk-theme burpsuite ffuf netexec visual-studio-code-bin
# Providers: arc-gtk-theme, ffuf, netexec
```

### Greeter Dark Theme

`/etc/lightdm/lightdm-gtk-greeter.conf`

```bash
[greeter]
#background=
#user-background=
theme-name=Arc-Dark
```

### SecLists

[SecLists](https://github.com/danielmiessler/SecLists)

```bash
sudo mkdir /usr/share/wordlists
sudo git clone https://github.com/danielmiessler/SecLists.git /usr/share/wordlists/seclists
```

### Searchsploit

[exploitdb](https://gitlab.com/exploit-database/exploitdb)

```bash
git clone https://gitlab.com/exploit-database/exploitdb.git /opt/exploit-database
ln -sf /opt/exploit-database/searchsploit /usr/local/bin/searchsploit
cp -n /opt/exploit-database/.searchsploit_rc ~/
nvim $HOME/.searchsploit_rc
# Exploits
path_array+=("/opt/exploit-database")

# Shellcodes
path_array+=("/opt/exploit-database")
```

### John The Ripper

```bash
git clone https://github.com/openwall/john.git
cd john/src
./configure && make
cd ../..
sudo mv john /opt
```

### Docker

```bash
sudo pacman -S docker
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo docker run hello-world
sudo usermod -aG docker $USER
sudo pacman -S docker-compose
```

Logout

### Firefox

- `about:config`
- `browser.fixup.domainsuffixwhitelist.htb`, `browser.fixup.domainsuffixwhitelist.thm`
- `true`

### Wireshark

```bash
sudo usermod -aG wireshark $USER
```

### Nvchad

`$HOME/.local/share/nvim/lazy/NvChad/lua/nvchad/configs/cmp.lua ` avoid autocomplete

```bash
dofile(vim.g.base46_cache .. "cmp")

local cmp = require "cmp"

local options = {
  completion = { completeopt = "menu,menuone", autocomplete = false },
```

### Dark Theme

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

### Tor

```bash
sudo pacman -S tor
sudo systemctl start tor
sudo systemctl status tor
sudo systemctl stop tor
```

### Proxychains

`/etc/proxychains.conf`

```bash
dynamic_chain
proxy_dns
```

### Remove packages

```bash
sudo pacman -Rns rxvt-unicode xdo dmenu
```

<img width="1907" height="1079" alt="arch" src="https://github.com/user-attachments/assets/601e0311-8627-4462-ad84-51e515b9055e" />

## Tools

-  `aws-cli-v2`
- `base-devel`
- `bat`
- `binutils`
- `cmake`
- `firefox` (option 5 ttf-dejavu)
- `ffuf`
- `fping`
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
- `nodejs`
- `npm`
- [NvChad](https://nvchad.com/docs/quickstart/install/)
- `openbsd-netcat`
- `openldap`
- `openvpn`
- `p7zip`
- `perl-image-exiftool`
- `picom`
- `pocl`
- `polybar`
- `proxychains-ng`
- `qt5ct`
- `radare2`
- `rust`
- `smbclient`
- `socat`
- `sqlmap`
- `tcpdump`
- `tor`
- `torbrowser-launcher`
- `tree`
- `ttf-hack-nerd`
- `type`
- `unzip`
- `virtualbox-guest-utils`
- `visual-studio-code-bin`
- `wireshark-qt`
- `wpscan`
- `xclip`
- `xorg-xset`

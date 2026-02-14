# Arch Linux Installation

<img width="600" height="199" alt="archlinux-logo-light-90dpi" src="https://github.com/user-attachments/assets/4a251114-a303-493b-80aa-6089db3cc82d" />

## Tools

- `base-devel`
- `firefox` (option 10 ttf-dejavu)
- `git`
- `kitty`
- `neovim`
- [NvChad](https://nvchad.com/docs/quickstart/install/)
- `openvpn`
- `polybar`
- `rust`
- `type`
- `virtualbox-guest-utils`
- `xclip`
- `xorg-xset`

```bash
sudo pacman -S base-devel firefox git kitty neovim openvpn polybar rust virtualbox-guest-utils xclip xorg-xset
```

```bash
sudo systemctl enable --now vboxservice
```

```bash
mkdir -p $HOME/.config/{bspwm,kitty,nvim,polybar,sxhkd}
```

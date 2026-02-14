# Arch Linux Installation

<img width="600" height="199" alt="archlinux-logo-light-90dpi" src="https://github.com/user-attachments/assets/4a251114-a303-493b-80aa-6089db3cc82d" />

## Tools

- `git`
- `kitty`
- `neovim`
- [NvChad](https://nvchad.com/docs/quickstart/install/)
- `openvpn`
- `polybar`
- `type`
- `virtualbox-guest-utils`
- `xclip`
- `xorg-xset`

```bash
sudo pacman -S git kitty neovim openvpn polybar virtualbox-guest-utils xclip xorg-xset
```

```bash
sudo systemctl enable --now vboxservice
```

```bash
mkdir -p $HOME/.config/{bspwm,kitty,nvim,polybar,sxhkd}
```

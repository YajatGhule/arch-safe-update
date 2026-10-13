# 🐾 arch-safe-update

A friendly, cat-themed wrapper around `yay -Syu` for Arch Linux that makes full
system upgrades safer: it backs up your rice, takes a Timeshift Btrfs snapshot,
shows you what's about to change, upgrades, and then checks for AUR packages
that need rebuilding.

```
        /\_____/\
       /  o   o  \
      ( ==  ^  == )
       )         (
      (           )
     ( (  )   (  ) )
    (__(__)___(__)__)
┌─────────────────────────────────────────┐
│  🐾 Arch Linux Safe Update Assistant 🐾 │
│   Guarding your rice, dots & packages!  │
└─────────────────────────────────────────┘
```

## What it does

| Step | Action |
|------|--------|
| 1/8 | Runs `~/.local/bin/rice-backup` (if present) to back up your dotfiles |
| 2/8 | Runs `checkrebuild` to list AUR packages that are *already* broken |
| 3/8 | Previews pending repo (`checkupdates`) and AUR (`yay -Qua`) updates |
| 4/8 | Creates an on-demand Timeshift snapshot tagged `pre-update YYYY-MM-DD HH:MM` |
| 5/8 | Runs `yay -Syu` non-interactively |
| 6/8 | Runs `checkrebuild` again and prints a ready-to-paste `yay -S --rebuild …` command; runs `~/.local/bin/rice-healthcheck` (if present) |
| 7/8 | If Quickshell was built against an older Qt than the one now installed, rebuilds its package (illogical-impulse's local PKGBUILD in `~/.cache/dots-hyprland`, or via `yay` for AUR builds) |
| 8/8 | Restarts `fprintd` and checks that a fingerprint is still enrolled (skipped if fprintd isn't installed) |

If nothing needs updating, it exits without asking for anything.

## Requirements

- Arch Linux (or an Arch-based distro)
- [`yay`](https://github.com/Jguer/yay)
- `pacman-contrib` (provides `checkupdates`)
- `rebuild-detector` (provides `checkrebuild`)
- `timeshift` configured in **Btrfs** mode

```sh
sudo pacman -S --needed pacman-contrib rebuild-detector timeshift
```

Optional:

- `fprintd`: the fingerprint sensor is restarted and checked after the update
- `binutils` (provides `strings`): needed to detect when Quickshell must be rebuilt for a new Qt
- `~/.local/bin/rice-backup`, `~/.local/bin/rice-healthcheck`, `~/.local/bin/rice-restore`:
  your own dotfile backup, health-check, and restore scripts. They're called if
  they exist and are executable, and skipped otherwise.

## Install

### From AUR (easiest)

If you use `yay` or another AUR helper:

```sh
yay -S arch-safe-update
```

The package will be installed to `/usr/bin/safe-update`. Then just run:

```sh
safe-update
```

### From GitHub (with installer)

```sh
git clone https://github.com/YajatGhule/arch-safe-update.git
cd arch-safe-update
./install.sh            # installs to ~/.local/bin/safe-update
```

Make sure `~/.local/bin` is on your `PATH`.

### Manual install

```sh
install -Dm755 safe-update ~/.local/bin/safe-update
```

Or system-wide:

```sh
sudo install -Dm755 safe-update /usr/local/bin/safe-update
```

## Usage

```sh
safe-update
```

The run is fully unattended: the only input is your `sudo` password, asked for
once after the pending updates are listed (nothing is asked if you're already up
to date). The credential is kept alive in the background for the Timeshift
snapshot, `yay -Syu` and the fprintd restart, and the keepalive stops when the
script exits. `yay` runs with `--noconfirm` and skips the clean/diff/edit menus.

## Rolling back

```sh
sudo timeshift --restore      # full system rollback to the pre-update snapshot
~/.local/bin/rice-restore     # dotfile rollback (if you use rice-backup)
```

## License

[MIT](LICENSE)

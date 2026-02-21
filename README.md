# Dotfiles

## Script Based

### Darwin/Linux/BSD

```sh
sh ~/dot/install.sh
```

### Windows

```powershell
.\install.ps1
```

## Nix Based

### nix-darwin

Install nix-darwin on macOS.
```sh
# Install nix on mac
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)

# Install nix-darwin
sudo nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake ~/dot#nico
```

Rebuild Command.
```sh
sudo darwin-rebuild switch --flake ~/dot#nico
```

### home-manager

Install home-manager with standalone way.
```sh
# Update Channel
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Install home-manager
nix-shell '<home-manager>' -A install
```

Build Command.
```sh
nix run --extra-experimental-features "nix-command flakes" home-manager -- switch -b backup --flake ~/dot#nico
```

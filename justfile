# List all commands
default:
  @just --list

# Install nix-darwin
install_darwin name:
  sudo nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake ~/dot#{{name}}

# Deploy nix-darwin config
build_darwin name:
  sudo darwin-rebuild switch --flake ~/dot#{{name}}

# Install home-manager
install_hm:
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install

# Deploy home-manager config
build_hm name:
  nix run --extra-experimental-features "nix-command flakes" home-manager -- switch -b backup --flake ~/dot#{{name}}

# Update flake
up:
  nix flake update

# Clean garbage
clean:
  nix-collect-garbage -d


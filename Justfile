# Variable Definition
flake_path := "~/dot"
config_name := "nico"

# Default Command: list all commands
@_default:
    just --list

# Install and initialize home-manager
alias ih := install-hm
install-hm:
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install

# Rebuild nix-darwin
alias rd := rebuild-darwin
rebuild-darwin:
    sudo darwin-rebuild switch --flake {{flake_path}}#{{config_name}}

# Rebuild home-manager
alias rh := rebuild-home
rebuild-home:
    nix run --extra-experimental-features "nix-command flakes" home-manager -- switch -b backup --flake {{flake_path}}#{{config_name}}

# Update Flake lock file
alias fu := flake-update
flake-update:
    nix flake update --flake {{flake_path}}

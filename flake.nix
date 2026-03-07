{
  description = "Nix Based Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      home-manager,
      ...
    }:
    let
      lib = import ./lib { inherit inputs; };
    in
    {
      darwinConfigurations = {
        "cya" = lib.mkDarwinConfig { username = "cya"; };
      };
      homeConfigurations = {
        "cya" = lib.mkHomeConfig { username = "cya"; };
      };
      devShells = lib.forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          python = import ./shell/python.nix { inherit pkgs; };
          r = import ./shell/r.nix { inherit pkgs; };
        }
      );
    };
}

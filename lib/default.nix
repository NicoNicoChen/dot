{ inputs }:
let
  inherit (inputs) nixpkgs nix-darwin nix-homebrew homebrew-core homebrew-cask home-manager;
in
{
  # Let devShells use appropriate platform automatically
  forAllSystems = nixpkgs.lib.genAttrs [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ];

  # Generate nix-darwin config
  mkDarwinConfig = { username, system ? "aarch64-darwin" }: nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs username; };
    modules =[
      ../darwin/common.nix
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          enableRosetta = if system == "aarch64-darwin" then true else false;
          user = username;
          autoMigrate = true;
          taps = {
            "homebrew/homebrew-core" = homebrew-core;
            "homebrew/homebrew-cask" = homebrew-cask;
          };
          mutableTaps = false;
        };
      }
    ];
  };

  # Generate home-manager config
  mkHomeConfig = { username, system ? "aarch64-darwin" }: home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg)[
        "vscode"
        "vscode-extension-MS-python-vscode-pylance"
      ];
    };
    extraSpecialArgs = { inherit inputs username; };
    modules =[
      ../home-manager/default.nix
    ];
  };
}

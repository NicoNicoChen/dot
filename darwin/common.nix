{ pkgs, config, ... }:
{
  nix = {
    enable = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = false;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
  system = {
    defaults = {
      menuExtraClock = {
        Show24Hour = true;
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };
      dock = {
        autohide = true;
        autohide-delay = 0.48;
        show-recents = false;
        orientation = "right";
        tilesize = 16;
        persistent-apps = [ ];
      };
      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };
    };
    primaryUser = "nico";
    stateVersion = 5;
    activationScripts.extraActivation.text = ''
      softwareupdate --install-rosetta --agree-to-license
    '';
  };
  environment = {
    systemPackages = with pkgs; [
      nixfmt
      just
    ];
  };
  security = {
    pam = {
      services = {
        sudo_local.touchIdAuth = true;
      };
    };
  };
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [ "mas" ];
    casks = [
      "google-chrome"
      "keka"
    ];
    masApps = {
      "Line" = 539883307;
      "uBlock Origin Lite" = 6745342698;
    };
  };
}

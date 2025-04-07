{
  isWSL,
  inputs,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
in {
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "25.05";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------
  # Packages I always want installed.
  home.packages = [
    # Fallback shell
    pkgs.zsh
    # Nix stuff
    pkgs.alejandra
    pkgs.nixd
    # TUI
    pkgs.lazygit
    pkgs.greetd.tuigreet

    # non-darwin packages
  ];

  #---------------------------------------------------------------------
  # dotfiles
  #---------------------------------------------------------------------
  home.file = {
    ".zshenv" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repositories/github.com/ivare/dotfiles/config/.zshenv";
    };
  };

  # TODO: FIX ALL PATHS HERE
  xdg.configFile = {
    # Always include these
    ghostty = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repositories/github.com/ivare/dotfiles/config/ghostty";
      recursive = true;
    };
    nvim = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repositories/github.com/ivare/dotfiles/config/nvim";
    };
    niri = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repositories/github.com/ivare/dotfiles/config/niri";
    };
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------
  programs.neovim = {
    enable = true;
  };

  programs.git = {
    enable = true;

    extraConfig = {};
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      whitelist = {
        # Should add the following: polymath, stormwater-ai, ivare
      };
    };
  };
}

{inputs, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  isLinux = pkgs.stdenv.isLinux;
in {
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "25.05";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------
  programs.git = {
    enable = true;
    userName = ""; # TODO: Fill this
    userEmail = ""; #TODO: Fill this
  };

  # Packages I always want installed.
  # TODO: Add in missing stuff
  home.packages = [
    # CLI tools
    pkgs.bat
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.ripgrep
    pkgs.curl
    pkgs.wget
    pkgs.fastfetch
    pkgs.onefetch
    # Nix stuff
    pkgs.alejandra
    pkgs.nixd
    # TUI
    pkgs.lazygit
  ];

  #---------------------------------------------------------------------
  # dotfiles
  #---------------------------------------------------------------------
  home.file = {
    # TODO:
    # Add in .zshenv
  };

  xdg.configFile = {
    # TODO: Add in astronvim/neovim
    # nvim = {};
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {whitelist = {};};
  };
}

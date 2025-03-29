{
  pkgs,
  inputs,
  ...
}: {
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;
  programs.niri.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # Since we're using zsh as our shell
  programs.zsh = {
    enable = true;
  };

  # TODO: Change out the username below
  users.users.ivare = {
    isNormalUser = true;
    home = "/home/ivare";
    extraGroups = ["wheel" "docker" "lxd"];
    shell = pkgs.zsh;
  };
}

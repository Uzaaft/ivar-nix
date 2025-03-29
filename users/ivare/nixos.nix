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
    extraGroups = ["wheel" "docker"];
    shell = pkgs.zsh;
    # TODO: I took these keys from your github. Remove the ones you dont need.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMDNN1wpwnpRwoR8Uv6Nj3LA9AwK49VCwZaisbFjmVi0"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJPHAayzDjKefWsQOEFYSOAkx7FtoNRJz6UAEuO8JWy"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBTpaGmDAzLeCdXhr3uDwGZezxpE78Lu4JewvHgyB12P"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHd2THj0rBxiXn9Y5qCSmtpCCR00LpBLUIQNWGRw8HDj"
    ];
  };
}

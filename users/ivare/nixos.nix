{
  pkgs,
  inputs,
  ...
}: {
  # https://github.com/nix-community/home-manager/pull/2408
  imports = [];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  programs.zsh.enable = true;

  users.users.ivare = {
    isNormalUser = true;
    home = "/home/ivare";
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$98wAwW7j5KikOUOe6h7t61$rb.FDBxKRulR6KLZgFWI9z.OtsCgzUIwkt5fXOX.aR5";
    openssh.authorizedKeys.keys = [
      # TODO: Add key here
    ];
  };
}

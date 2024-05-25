{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/cli.nix
    ./modules/coding.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/lazygit.nix
    ./modules/ssh.nix
    ./modules/sway.nix
    ./modules/waybar.nix
    ./modules/zsh.nix
    ./services/dev.nix
    ./services/lila.nix
  ];

  home = {
    username = "thib";
    homeDirectory = "/home/thib";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
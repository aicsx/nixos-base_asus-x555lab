{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
    qtile = "qtile";
    nvim = "nvim";
    alacritty = "alacritty";
    rofi = "rofi";
    picom = "picom";
    };
in

{
  home.username = "ax";
  home.homeDirectory = "/home/ax";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#axos";
    };
  };


   xdg.configFile = builtins.mapAttrs (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
    }) configs;

  home.packages = with pkgs; [
  neovim
  ripgrep
  nil
  nixpkgs-fmt
  nodejs
  gcc
  rofi
  picom
  papirus-icon-theme
  imv
  ];
}

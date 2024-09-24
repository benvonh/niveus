{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./neovim.nix
    ./starship.nix
  ];

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = false;

  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    stateVersion = "24.05";
    packages = with pkgs; [
      fd
      htop
      tldr
      ripgrep
    ];
  };

  programs.home-manager.enable = true;

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    userName = "benvonh";
    userEmail = "benjaminvonsnarski@gmail.com";
  };

  programs.bat = {
    enable = true;
    config.theme = "base16";
    extraPackages = with pkgs.bat-extras; [
      batman batpipe batgrep batdiff batwatch prettybat
    ];
  };

  programs.eza = {
    git = true;
    icons = true;
    enable = true;
    extraOptions = [ "--group-directories-first" ];
  };

  programs.zoxide.enable = true;
}

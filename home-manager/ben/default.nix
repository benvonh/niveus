{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./neovim.nix
    ./starship.nix
  ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

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

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    syntaxHighlighting.enable = true;
    shellAliases = {
      cd = "z";
      ga = "git add";
      gd = "git diff";
      gc = "git commit";
      gs = "git status";
      gp = "git pull && git push";
      ngc = "nix-collect-garbage -d";
      hms = "home-manager switch --flake ~/niveus";
    };
  };
}

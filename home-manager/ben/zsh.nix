{ config, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";
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
    sessionVariables = {
      EDITOR = "nvim";
    };
    history = {
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
  };
}

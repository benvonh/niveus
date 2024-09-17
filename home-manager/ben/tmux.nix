{ pkgs, ... }:
{
  programs.tmux = {
    mouse = true;
    enable = true;
    clock24 = true;
    shortcut = "t"; # maybe s?
    baseIndex = 1;
    escapeTime = 300;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      catppuccin
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60'
        '';
      }
    ];
    extraConfig = ''
      bind | split-window -h
      bind - split-window -v
      set -g status-position top
    '';
  };
}

{ pkgs, ... }:
let
  tmux_cheatsheet = builtins.path { path = ./tmux-cheatsheet.txt; };
in
{
  programs.tmux = {
    mouse = true;
    enable = true;
    clock24 = true;
    shortcut = "t";
    baseIndex = 1;
    escapeTime = 300;
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_status 'icon'

          set -g @catppuccin_application_color "#{thm_red}"
          set -g @catppuccin_directory_color "#{thm_orange}"
          set -g @catppuccin_host_color "#{thm_yellow}"
          set -g @catppuccin_date_time_color "#{thm_cyan}"

          set -g @catppuccin_date_time_icon ''
          set -g @catppuccin_date_time_text '%H:%M'

          set -g @catppuccin_status_left_separator ' '
          set -g @catppuccin_status_right_separator ''
          set -g @catppuccin_status_connect_separator 'no'
          set -g @catppuccin_status_modules_right "application directory host session date_time cpu"
        '';
      }
      vim-tmux-navigator
      fuzzback
      extrakto
      copycat
      yank
      cpu
    ];
    extraConfig = ''
      set-option -sa terminal-overrides ',xterm-256color:RGB'
      set -g status-position top
      bind | split-window -h
      bind - split-window -v
      bind h popup -w 62 -h 23 "less ${tmux_cheatsheet}"
    '';
  };
}

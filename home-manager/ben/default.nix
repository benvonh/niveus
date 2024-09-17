{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
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
      ga = "git add";
      gd = "git diff";
      gc = "git commit";
      gs = "git status";
      gp = "git pull && git push";
      ngc = "nix-collect-garbage -d";
      hms = "home-manager switch --flake ~/niveus";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "[](color_orange)"
        "$os"
        "$username"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_aqua)"
        "$git_branch"
        "$git_status"
        "[](fg:color_aqua bg:color_blue)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:color_blue bg:color_bg3)"
        "$docker_context"
        "$conda"
        "[](fg:color_bg3 bg:color_bg1)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break$character"
      ];

      palette = "gruvbox_dark";

      palettes = {
        gruvbox_dark = {
          color_fg0 = "#fbf1c7";
          color_bg1 = "#3c3836";
          color_bg3 = "#665c54";
          color_blue = "#458588";
          color_aqua = "#689d6a";
          color_green = "#98971a";
          color_orange = "#d65d0e";
          color_purple = "#b16286";
          color_red = "#cc241d";
          color_yellow = "#d79921";
        };
      };

      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";

        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          EndeavourOS = "";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $user ]($style)";
      };

      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";

        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };

      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      conda = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
      };
    };
  };

  programs.nixvim = {
    enable = true;
    colorscheme = "onedark";
    colorschemes = {
      catppuccin.enable = true;
      gruvbox.enable = true;
      onedark.enable = true;
    };
    opts = {
      # tabs
      expandtab = true;
      autoindent = true;
      shiftwidth = 4;
      softtabstop = 4;
      tabstop = 4;

      smartindent = true;
      smartcase = true;
      smarttab = true;

      scrolloff = 16;

      colorcolumn = "120";
      cursorline = true;

      swapfile = false;

      number = true;

      pumheight = 8;
      pumwidth = 16;

      signcolumn = "yes";

      wrap = false;
    };
    globals.mapleader = " ";
    keymaps = [
      { mode = "i"; key = "<c-c>"; action = "<esc>"; }

      { mode = "v"; key = "<"; action = "<gv"; }
      { mode = "v"; key = ">"; action = ">gv"; }
      { mode = "v"; key = "J"; action = ":m '>+1<cr>gv=gv"; }
      { mode = "v"; key = "K"; action = ":m '<-2<cr>gv=gv"; }
      { mode = "v"; key = "p"; action = "\"_dP"; }

      { mode = "n"; key = "n"; action = "nzz"; }
      { mode = "n"; key = "N"; action = "Nzz"; }
      { mode = "n"; key = "<a-h>"; action = "<c-w>H"; }
      { mode = "n"; key = "<a-j>"; action = "<c-w>J"; }
      { mode = "n"; key = "<a-k>"; action = "<c-w>K"; }
      { mode = "n"; key = "<a-l>"; action = "<c-w>L"; }
      { mode = "n"; key = "<c-u>"; action = "<c-u>zz"; }
      { mode = "n"; key = "<c-d>"; action = "<c-d>zz"; }
      { mode = "n"; key = "H"; action = "<cmd>bprev<cr>"; }
      { mode = "n"; key = "L"; action = "<cmd>bnext<cr>"; }

      { mode = ""; key = "<leader>y"; action = "\"+y"; }
      { mode = ""; key = "<leader>Y"; action = "\"+Y"; }
      { mode = ""; key = "<leader>d"; action = "\"_d"; }
      { mode = ""; key = "<leader>D"; action = "\"_D"; }

      { mode = "n"; key = "<leader>q"; action = "<cmd>q<cr>"; }
      { mode = "n"; key = "<leader>w"; action = "<cmd>w<cr>"; }
      { mode = "n"; key = "<leader>x"; action = "<cmd>x<cr>"; }
      { mode = "n"; key = "<leader>a"; action = "<cmd>qa<cr>"; }
      { mode = "n"; key = "<leader>s"; action = "<cmd>wa<cr>"; }
      { mode = "n"; key = "<leader>z"; action = "<cmd>xa<cr>"; }
      { mode = "n"; key = "<leader>v"; action = "<cmd>vsplit<cr>"; }

      { mode = "n"; key = "<leader>t"; action = "<cmd>TodoTelescope<cr>"; }
      { mode = "n"; key = "<leader>e"; action = "<cmd>NvimTreeToggle<cr>"; }
      { mode = "n"; key = "<leader>l"; action = "<cmd>Telescope live_grep<cr>"; }
      { mode = "n"; key = "<leader>f"; action = "<cmd>Telescope find_files<cr>"; }
      { mode = "n"; key = "<leader>r"; action = "<cmd>TroubleToggle lsp_references<cr>"; }
      { mode = "n"; key = "<leader>dd"; action = "<cmd>TroubleToggle document_diagnostics<cr>"; }
      { mode = "n"; key = "<leader>dw"; action = "<cmd>TroubleToggle workspace_diagnostics<cr>"; }
      { mode = "n"; key = "<leader>df"; action = "<cmd>TroubleToggle quickfix<cr>"; }
    ];

    autoCmd = [
      {
        event = "FileType";
        pattern = [ "c" "cpp" "nix" ];
        command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
      }
    ];

    plugins.which-key = {
      enable = true;
      registrations = {
        "<leader>q" = "Quit Buffer";
        "<leader>w" = "Write Buffer";
        "<leader>x" = "Write & Quit Buffer";
        "<leader>a" = "Quit All Buffers";
        "<leader>s" = "Save All Buffers";
        "<leader>z" = "Save & Exit";
        "<leader>v" = "Split Vertical";
        "<leader>t" = "Search TODO";
        "<leader>e" = "Toggle File Explorer";
        "<leader>l" = "Live Grep";
        "<leader>f" = "Find File";
        "<leader>r" = "Show References";
        "<leader>dd" = "Show Document Diagnostics";
        "<leader>dw" = "Show Workspace Diagnostics";
        "<leader>df" = "Show Quick Fixes";
      };
    };

    plugins.treesitter = {
      enable = true;
    };

    plugins.telescope.enable = true;
    plugins.trouble.enable = true;
    plugins.tmux-navigator.enable = true;
    plugins.todo-comments.enable = true;
    plugins.comment.enable = true;
    plugins.rainbow-delimiters.enable = true;
    plugins.nix.enable = true;
    plugins.lastplace.enable = true;

    plugins.nvim-autopairs = {
      enable = true;
      settings = {
        enable_abbr = true;
        check_ts = true;
        map_c_w = true;
      };
    };

    plugins.indent-blankline = {
      enable = true;
      settings = {
        indent.char = "▏";
        scope.show_end = false;
        scope.show_start = false;
      };
    };

    plugins.lualine = {
      enable = true;
      globalstatus = true;
      sectionSeparators.left = "";
      sectionSeparators.right = "";
      componentSeparators.left = "";
      componentSeparators.right = "";
    };

    plugins.nvim-tree = {
      enable = true;
      git.ignore = false;
      hijackCursor = true;
      diagnostics.enable = true;
      diagnostics.showOnDirs = true;
      updateFocusedFile.enable = true;
      renderer.indentMarkers.enable = false;
      renderer.icons.gitPlacement = "after";
    };

    plugins.lsp = {
      enable = true;
      keymaps = {
        diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
        };
        lspBuf = {
          K = "hover";
          gd = "definition";
          gD = "declaration";
          gi = "implementation";
          go = "type_definition";
          gr = "references";
          gs = "signature_help";
          "<F2>" = "rename";
          "<F3>" = "format";
          "<F4>" = "code_action";
        };
      };
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        cmake.enable = true;
        csharp-ls.enable = true;
        cssls.enable = true;
        dockerls.enable = true;
        html.enable = true;
        htmx.enable = true;
        java-language-server.enable = true;
        jsonls.enable = true;
        ltex.enable = true;
        lua-ls.enable = true;
        nixd.enable = true;
        pyright.enable = true;
        yamlls.enable = true;
      };
    };

    plugins.cmp = {
      enable = true;
      settings.sources = [
        { name = "nvim_lsp_document_symbol"; }
        { name = "nvim_lsp_signature_help"; }
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
    };
  };
}

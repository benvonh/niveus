{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

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

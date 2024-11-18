# TODO: Fix sessions and buffer management :)
{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;

    colorscheme = "catppuccin";

    colorschemes = {
      catppuccin.enable = true;
      gruvbox.enable = true;
      onedark.enable = true;
    };

    opts = {
      # tabs
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;
      # indents
      autoindent = true;
      # smart options
      smarttab = true;
      smartcase = true;
      smartindent = true;
      # show numbers
      number = true;
      # highlight cursor row
      cursorline = true;
      # offset scrolling
      scrolloff = 16;
      # pop-up menu
      pumheight = 8;
      pumwidth = 16;
      # column options
      signcolumn = "yes";
      colorcolumn = "120";
      # dark theme
      background = "dark";
      # no swap file
      swapfile = false;
      # no wrapping
      wrap = false;
      # track for undo
      undofile = true;
      # split direction
      splitbelow = true;
      splitright = true;
      # prompt confirmation
      confirm = true;
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = [ "c" "cpp" "nix" ];
        command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
      }
    ];

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

      # { mode = ""; key = "<leader>y"; action = "\"+y"; }
      # { mode = ""; key = "<leader>Y"; action = "\"+Y"; }
      # { mode = ""; key = "<leader>d"; action = "\"_d"; }
      # { mode = ""; key = "<leader>D"; action = "\"_D"; }

      { mode = "n"; key = "<leader>q"; action = "<cmd>q<cr>"; }
      { mode = "n"; key = "<leader>w"; action = "<cmd>w<cr>"; }
      { mode = "n"; key = "<leader>x"; action = "<cmd>x<cr>"; }
      { mode = "n"; key = "<leader>a"; action = "<cmd>qa<cr>"; }
      { mode = "n"; key = "<leader>s"; action = "<cmd>wa<cr> <cmd>SessionSave<cr>"; }
      { mode = "n"; key = "<leader>z"; action = "<cmd>xa<cr>"; }
      { mode = "n"; key = "<leader>v"; action = "<cmd>vsplit<cr>"; }
      { mode = "n"; key = "<leader>."; action = "<cmd>SessionSearch<cr>"; }

      { mode = "n"; key = "<leader>t"; action = "<cmd>TodoTelescope<cr>"; }
      { mode = "n"; key = "<leader>e"; action = "<cmd>NvimTreeToggle<cr>"; }
      { mode = "n"; key = "<leader>l"; action = "<cmd>Telescope live_grep<cr>"; }
      { mode = "n"; key = "<leader>f"; action = "<cmd>Telescope find_files<cr>"; }
      { mode = "n"; key = "<leader>r"; action = "<cmd>TroubleToggle lsp_references<cr>"; }
      { mode = "n"; key = "<leader>dd"; action = "<cmd>TroubleToggle document_diagnostics<cr>"; }
      { mode = "n"; key = "<leader>dw"; action = "<cmd>TroubleToggle workspace_diagnostics<cr>"; }
      { mode = "n"; key = "<leader>df"; action = "<cmd>TroubleToggle quickfix<cr>"; }
    ];

    plugins.which-key = {
      enable = true;
      registrations = {
        # Basics
        "<leader>q" = "Quit buffer";
        "<leader>w" = "Write buffer";
        "<leader>x" = "Write & Quit buffer";
        "<leader>a" = "Quit all buffers";
        "<leader>s" = "Save all buffers";
        "<leader>z" = "Save & Exit";
        "<leader>v" = "Split vertical";
        # Plug-ins
        "<leader>." = "Change session";
        "<leader>t" = "Search TODO";
        "<leader>e" = "Toggle file explorer";
        "<leader>l" = "Live grep";
        "<leader>f" = "Find file";
        "<leader>r" = "Show references";
        "<leader>dd" = "Show document diagnostics";
        "<leader>dw" = "Show workspace diagnostics";
        "<leader>df" = "Show quick fixes";
        # Native LSP
        "<leader>j" = "Jump to next diagnostic";
        "<leader>k" = "Jump to last diagnostic";
        gd = "Go to definition";
        gD = "Go to declaration";
        gi = "Go to implementation";
        go = "Go to type definition";
        gr = "Go to references";
        gs = "Go to signature help";
      };
    };

    plugins.nix.enable = true;
    plugins.comment.enable = true;
    plugins.trouble.enable = true;
    plugins.telescope.enable = true;
    plugins.treesitter.enable = true;
    plugins.todo-comments.enable = true;
    plugins.tmux-navigator.enable = true;
    plugins.rainbow-delimiters.enable = true;
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

    plugins.bufferline = {
      enable = true;
      offsets = [
        {
          filetype = "NvimTree";
          text = "File Explorer";
          text_align = "center";
          separator = true;
        }
      ];
    };

    # TODO: Make it look nicer
    # remove arrows?
    # change folder colour?
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

    plugins.auto-session = {
      enable = true;
      autoSave.enabled = true;
      autoRestore.enabled = true;
      autoSession = {
        enabled = true;
        enableLastSession = true;
        createEnabled = false;
      };
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
      settings = {
        sources = [
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "nvim_lsp_document_symbol"; }
        ];
        mapping = {
          "<cr>" = "cmp.mapping.confirm()";
          "<c-e>" = "cmp.mapping.abort()";
          "<c-u>" = "cmp.mapping.scroll_docs(4)";
          "<c-d>" = "cmp.mapping.scroll_docs(-4)";
          "<tab>" = "cmp.mapping.select_next_item()";
          "<s-tab>" = "cmp.mapping.select_prev_item()";
        };
      };
    };
    # cmdline."/".sources = [ { name = "buffer"; } ];
    # cmdline."?".sources = [ { name = "buffer"; } ];
    # cmdline.":".sources = [
    #   { name = "cmdline"; }
    #   { name = "buffer"; }
    #   { name = "path"; }
    # ];
  };
}

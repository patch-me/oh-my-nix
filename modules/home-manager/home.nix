{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "brioche";
  home.homeDirectory = "/home/brioche";
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    neofetch

    # zip
    zip
    unzip
    xz
    p7zip

    # utils
    ripgrep
    jq
    eza
    lsd
    fzf
    pulsemixer
    lshw

    nmap
    dnsutils

    discord
    notion
    notion-app-enhanced
    signal-desktop-beta
    gitflow
    lazygit
    lazydocker
    insomnia
    grc
    bat
    broot
    procs
    fd
    mpc-cli
    ncmpcpp
    scrcpy
    localsend
    drawio
    eslint_d
    prettierd
    biome
    python312Packages.flake8
  ];

  programs.git = {
    enable = true;
    userName = "Brioche";
    userEmail = "thomasderudder@sfr.fr";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if status is-interactive
      and not set -q TMUX
          exec tmux
      end
      set fish_greeting
    '';
    # plugins = with pkgs; [ fishPlugins.z ];
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      # Manually packaging and enable a plugin
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "pair";
        src = pkgs.fishPlugins.pisces.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "fifc";
        src = pkgs.fishPlugins.fifc.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
    ];
  };
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    prefix = "C-Space";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
    ];
    extraConfig = ''
      set -g mouse on
      set -g set-clipboard on
      set-window-option -g mode-keys vi

      set -g @shell_mode 'vi'
      set -g @yank_selection 'clipboard'
      set -g @yank_with_mouse 'on'
      set -g @yank_selection_mouse 'clipboard'
      set -g @yank_action 'copy-pipe-and-cancel'
      bind-key -T copy-mode-vi Enter send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi C-j send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi D send-keys -X copy-end-of-line
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi A send-keys -X append-selection-and-cancel
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
    '';
  };

  programs.neovim = let
    toLua = str: ''
      lua << EOF
      ${str}
      EOF
    '';
    toLuaFile = file: ''
      lua << EOF
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua ''require("Comment").setup()'';
      }
      {
        plugin = tokyonight-nvim;
        config = "colorscheme tokyonight-night";
      }
      transparent-nvim
      catppuccin-vim
      kanagawa-nvim
      oxocarbon-nvim
      neodev-nvim
      nvim-cmp
      vim-bookmarks
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }
      {
        plugin = cloak-nvim;
        config = toLuaFile ./nvim/plugin/cloak.lua;
      }

      telescope-undo-nvim
      telescope-fzf-native-nvim
      telescope-vim-bookmarks-nvim
      telescope-coc-nvim
      telescope-file-browser-nvim
      telescope-project-nvim
      telescope-media-files-nvim
      telescope_hoogle
      telescope-live-grep-args-nvim
      harpoon2
      {
        plugin = nvim-autopairs;
        config = toLua ''require("nvim-autopairs").setup()'';
      }

      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      lsp-zero-nvim
      cmp-path
      cmp-buffer
      lsp-zero-nvim

      luasnip
      friendly-snippets

      lualine-nvim
      nvim-web-devicons
      vim-dadbod
      vim-dadbod-ui
      tailwindcss-colors-nvim
      {
        plugin = copilot-vim;
        config = toLua "vim.g.copilot_enabled = 0";
      }
      {
        plugin = conform-nvim;
        config = toLuaFile ./nvim/plugin/format.lua;
      }
      {
        plugin = nvim-lint;
        config = toLuaFile ./nvim/plugin/lint.lua;
      }

      vimtex

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-markdown
          p.tree-sitter-vimdoc
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-rust
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      vim-nix
      lazygit-nvim
      markdown-preview-nvim
      trouble-nvim

      vim-visual-multi

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/remap.lua}
      ${builtins.readFile ./nvim/set.lua}
    '';

    # extraLuaConfig = ''
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plextensionsFromVscodeMarketplaceugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    # '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = { };
  # programs.neovim = {
  #  enable = true;
  # };

  services.mpd = {
    enable = true;
    musicDirectory = "~/music/";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
    network.listenAddress = "any";
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        ms-toolsai.jupyter
        esbenp.prettier-vscode
        charliermarsh.ruff
        dbaeumer.vscode-eslint
        davidanson.vscode-markdownlint
        formulahendry.auto-rename-tag
        aaron-bond.better-comments
        naumovs.color-highlight
        ms-toolsai.datawrangler
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "auto-close-tag";
          publisher = "formulahendry";
          version = "0.5.5"; # Update to the latest version
          sha256 =
            "gtwKmCk9LcWtr+oJ7DUK+Zv1824aZdVOqkEe2YplE9I="; # lib.fakeSha256;
        }
        {
          name = "vs-code-prettier-eslint";
          publisher = "rvest";
          version = "6.0.0"; # Update to the latest version
          sha256 = "PogNeKhIlcGxUKrW5gHvFhNluUelWDGHCdg5K+xGXJY=";
        }
        {
          name = "rust-analyzer";
          publisher = "rust-lang";
          version = "0.4.2035"; # Update to the latest version
          sha256 = "lbS9YE5sleISA7ro5NgtSx92D9xEUiSoH3K52UBI8so=";
        }
        {
          name = "vscode-sort-json";
          publisher = "richie5um2";
          version = "1.20.0"; # Update to the latest version
          sha256 =
            "Jobx5Pf4SYQVR2I4207RSSP9I85qtVY6/2Nvs/Vvi/0="; # lib.fakeSha256;
        }
      ];
  };
  home.sessionVariables = { EDITOR = "nvim"; };

  programs.home-manager.enable = true;
}

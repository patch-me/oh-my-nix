{ config, pkgs, ... }:

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
    vscode
    gitflow
    lazygit
    lazydocker
    insomnia
  ];




  programs.git = {
    enable = true;
    userName = "Brioche";
    userEmail = "thomasderudder@sfr.fr";
  };




  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
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
          config = toLua "require(\"Comment\").setup()";
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

        {
          plugin = telescope-undo-nvim;
          config = toLuaFile ./nvim/plugin/undo.lua;
        }

        telescope-fzf-native-nvim

        cmp_luasnip
        cmp-nvim-lsp

        luasnip
        friendly-snippets


        lualine-nvim
        nvim-web-devicons


        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
          ]));
          config = toLuaFile ./nvim/plugin/treesitter.lua;
        }

        vim-nix

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
      #   ${builtins.readFile ./nvim/plugin/lsp.lua}
      #   ${builtins.readFile ./nvim/plugin/cmp.lua}
      #   ${builtins.readFile ./nvim/plugin/telescope.lua}
      #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
      # '';
    };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = { };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}

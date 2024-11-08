{ config, pkgs, lib, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
      }) { config = config.nixpkgs.config; };
    };
  };

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    unstable.signal-desktop
    neofetch
    fastfetch

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
    vscodium
    marksman
    freecad
  ];

  services.clipmenu.enable = true;
  services.picom = {
    enable = true;
    backend = "glx";
    activeOpacity = 0.9;
    inactiveOpacity = 0.85;
    fade = true;
    fadeDelta = 5;

    settings = {
      blur = {
        method = "dual_kawase";
        strength = 6;
        size = 10;
        deviation = 5.0;
        background = true;
      };
      corner-radius = 8.0;
      round-borders = 1;
      rounded-corners-exclude = [ "class_g = 'dwm'" ];
    };
  };

  programs.git = {
    enable = true;
    userName = "ripitchip";
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
      # tmuxPlugins.pomodoro.overrideAttrs
      # (_: {
      #   src = pkgs.fetchFromGitHub {
      #     owner = "olimorris";
      #     repo = "tmux-pomodoro-plus";
      #     rev = "48ea2217e1e397a0f9bab30e80f3e7d3778671ae";
      #     sha256 = "sha256-QsA4i5QYOanYW33eMIuCtud9WD97ys4zQUT/RNUmGes=";
      #   };
      # })
      (tmuxPlugins.mkTmuxPlugin {
        pluginName = "tmux-super-fingers";
        version = "unstable-2023-01-06";
        src = pkgs.fetchFromGitHub {
          owner = "artemave";
          repo = "tmux_super_fingers";
          rev = "2c12044984124e74e21a5a87d00f844083e4bdf7";
          sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
        };
      })

      # graphics
      tmuxPlugins.cpu
      tmuxPlugins.battery
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

      #################################### COLORS ###################################
      color_bg="#2e323b"
      color_fg="#282c34"
      color_green="#98c379"
      color_yellow="#e5c07b"
      color_red="#e06c75"
      color_blue="#61afef"
      color_cyan="#56b6c2"
      color_purple="#c678dd"
      color_gray="#5c6370"
      color_buffer="#939aa3"
      color_selection="#3e4452"
      color_light_gray="#5c6370"



      #################################### PLUGINS ###################################
      set -g @pomodoro_toggle 'p'
      set -g @pomodoro_cancel 'P'
      set -g @pomodoro_repeat 'off'
      set -g @pomodoro_notifications 'on'
      set -g @pomodoro_sound 'Pop'
      set -g status-right "#(pomodoro_status)"

      mode_separator=""
      set -g @mode_indicator_empty_prompt " TMUX #[default]#[fg=$color_fg]$mode_separator"
      set -g @mode_indicator_empty_mode_style fg=$color_purple,bold
      set -g @mode_indicator_prefix_prompt " TMUX #[default]#[fg=$color_blue]$mode_separator"
      set -g @mode_indicator_prefix_mode_style fg=$color_bg,bg=$color_blue,bold
      set -g @mode_indicator_copy_prompt " COPY #[default]#[fg=$color_green]$mode_separator"
      set -g @mode_indicator_copy_mode_style fg=$color_bg,bg=$color_green,bold
      set -g @mode_indicator_sync_prompt " SYNC #[default]#[fg=$color_red]$mode_separator"
      set -g @mode_indicator_sync_mode_style fg=$color_bg,bg=$color_red,bold

      # tmux cpu
      set -g @cpu_percentage_format "%3.0f%%"

      # tmux-online-status
      set -g @route_to_ping "vultr.net"   # Use a UK based site to ping
      set -g @online_icon "#[fg=$color_gray]"
      set -g @offline_icon "#[fg=$color_red]"

      # tmux-pomodoro
      set -g @pomodoro_on "  #[fg=$color_red] "
      set -g @pomodoro_complete "  #[fg=$color_green] "
      set -g @pomodoro_pause "  #[fg=$color_yellow] "
      set -g @pomodoro_prompt_break "  #[fg=$color_green] ?"
      set -g @pomodoro_prompt_pomodoro "  #[fg=$color_red] ?"
      set -g @pomodoro_interval_display "#[fg=$color_gray]|#[fg=italics]%s"

      # tmux-battery
      set -g @batt_icon_charge_tier8 ""
      set -g @batt_icon_charge_tier7 ""
      set -g @batt_icon_charge_tier6 ""
      set -g @batt_icon_charge_tier5 ""
      set -g @batt_icon_charge_tier4 ""
      set -g @batt_icon_charge_tier3 ""
      set -g @batt_icon_charge_tier2 ""
      set -g @batt_icon_charge_tier1 ""

      set -g @batt_icon_status_charged " "
      set -g @batt_icon_status_charging "  "
      set -g @batt_icon_status_discharging " "
      set -g @batt_icon_status_attached " "
      set -g @batt_icon_status_unknown " "

      set -g @batt_remain_short true

      #################################### OPTIONS ###################################

      set -g status on
      set -g status-justify centre
      set -g status-position bottom
      set -g status-left-length 90
      set -g status-right-length 90
      set -g status-style "bg=$color_fg"
      # set -g window-style ""
      # set -g window-active-style ""

      set -g pane-active-border fg=$color_gray
      set -g pane-border-style fg=$color_gray

      set -g message-style bg=$color_blue,fg=$color_bg
      setw -g window-status-separator "   "
      set-window-option -g mode-style bg=$color_purple,fg=$color_bg

      #################################### FORMAT ####################################

      set -g status-left "#{tmux_mode_indicator} #{online_status}  #[fg=$color_gray]%R#{pomodoro_status}"
      set -g status-right "#[fg=$color_gray]#{battery_icon_charge}  #{battery_percentage}#{battery_icon_status}#{battery_remain}  CPU:#{cpu_percentage} "
      setw -g window-status-format "#[fg=$color_gray,italics]#I: #[noitalics]#W"
      setw -g window-status-current-format "#[fg=$color_purple,italics]#I: #[fg=$color_buffer,noitalics,bold]#W"
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
      {
        plugin = vimtex;
        config = toLuaFile ./nvim/plugin/latex.lua;
      }

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
          p.tree-sitter-markdown
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
    package = pkgs.vscodium;
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
        ms-python.python
        ms-python.black-formatter
        unifiedjs.vscode-mdx
        yzhang.markdown-all-in-one
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
          name = "vscode-sort-json";
          publisher = "richie5um2";
          version = "1.20.0"; # Update to the latest version
          sha256 =
            "Jobx5Pf4SYQVR2I4207RSSP9I85qtVY6/2Nvs/Vvi/0="; # lib.fakeSha256;
        }
        {
          name = "theme-monokai-pro-vscode";
          publisher = "monokai";
          version = "1.3.2"; # Update to the latest version
          sha256 = "PznyVIzlKwN21sL+8oC353yxbm1V7ZEHCYQGPSpJRXM=";
        }
      ];
    userSettings = {
      "editor.fontFamily" = "'FiraCode Nerd Font Mono', 'monospace'";
      "editor.rulers" = [ 80 ];
      "editor.fontSize" = 11;
      "editor.formatOnSave" = true;
      "editor.insertSpaces" = true;
      "editor.tabSize" = 2;
      "editor.detectIndentation" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "notebook.formatOnCellExecution" = true;
      "notebook.formatOnSave.enabled" = true;

      "notebook.codeActionsOnSave" = { "source.organizeImports" = true; };

      "markdown.preview.typographer" = true;
      "files.associations" = { "*.mdx" = "markdown"; };

      "[python]" = {
        "editor.formatOnSave" = true;
        "editor.tabSize" = 4;
        # "editor.defaultFormatter"= "ms-python.black-formatter";  
        "editor.defaultFormatter" = "charliermarsh.ruff";
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = "explicit";
          "source.fixAll" = "explicit";
        };
      };
      "black-formatter.args" =
        [ "--line-length" "80" "--experimental-string-processing" ];
      "[cpp]" = { "editor.defaultFormatter" = "xaver.clang-format"; };
      "[toml]" = { "editor.defaultFormatter" = "tamasfe.even-better-toml"; };
      "[jsonc]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      "[csharp" = {
        "editor.tabSize" = 4;
        "editor.formatOnSaveMode" = "file";
        "editor.defaultFormatter" = "csharpier.csharpier-vscode";
      };

      "code-runner.runInTerminal" = true;
      "code-runner.clearPreviousOutput" = false;

      # // Override http proxy support json error:
      "http.proxySupport" = "off";

      "workbench.iconTheme" = "material-icon-theme";
      "workbench.editorAssociations" = { "*.svg" = "default"; };
      "emmet.triggerExpansionOnTab" = true;
      "cmake.showOptionsMovedNotification" = false;
      "hediet.vscode-drawio.resizeImages" = null;
      "security.workspace.trust.untrustedFiles" = "open";
      "terminal.external.windowsExec" = "C:\\Program Files\\Git\\bin\\bash.exe";
      "terminal.integrated.defaultProfile.windows" = "PowerShell";
      "omnisharp.useEditorFormattingSettings" = true;
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = false;
        "markdown" = true;
        "scminput" = false;
        "csharp" = true;
      };
      "docker-compose.enableTelemetry" = true;
      "cmake.configureOnOpen" = true;
      "evenBetterToml.formatter.allowedBlankLines" = 1;
      "terminal.integrated.inheritEnv" = false;
      "settingsSync.ignoredExtensions" = [
        "darkempire78.discord-tools"
        "psioniq.psi-header"
        "visualstudiotoolsforunity.vstuc"
      ];
      "workbench.sideBar.location" = "right";
      "extensions.experimental.affinity" = { "asvetliakov.vscode-neovim" = 1; };
      "liveshare.notebooks.allowGuestExecuteCells" = true;
      "terminal.integrated.shell.windows" = { "maxRows" = 50; };
      "notebook.output.wordWrap" = true;
      "notebook.output.scrolling" = true;
      "notebook.output.textLineLimit" = 16;
      "redhat.telemetry.enabled" = true;
      "github.copilot.editor.enableAutoCompletions" = true;
      "notebook.cellToolbarLocation" = {
        "default" = "right";
        "jupyter-notebook" = "left";
      };
    };
  };
  home.sessionVariables = { EDITOR = "nvim"; };

  programs.home-manager.enable = true;
}

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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = { };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}

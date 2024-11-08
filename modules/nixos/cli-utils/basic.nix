{ pkgs, lib, config, ... }: {

  options = { cliTools.enable = lib.mkEnableOption "enables dwm"; };

  config = lib.mkIf config.cliTools.enable {
    environment.systemPackages = with pkgs; [
      neofetch
      acpi
      zip
      unzip
      arandr
      wget
      tree-sitter
      zathura
      fd
      tmux
      protobuf
      steam-run
      plantuml
      graphviz
    ];
  };
}

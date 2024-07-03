{ pkgs, lib, config, ... }: {

  options = {
    firefox.enable = lib.mkEnableOption "enables all dev chat apps";
  };

  config = lib.mkIf config.firefox.enable {
    environment.systemPackages = with pkgs; [
      firefox
      gnome.nautilus
    ];

  };
}

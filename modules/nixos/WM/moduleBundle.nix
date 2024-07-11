{ pkgs, lib, config, ... }: {
  options = {
    WM.enable = lib.mkEnableOption "enables window manager (gnome kde ect";
  };
  imports = [ ./dwm.nix ];

  config = lib.mkIf config.WM.enable {
    services.xserver = {
      enable = true;
      displayManager = { gdm.enable = true; };
    };
    security.polkit.enable = true;
  };

}

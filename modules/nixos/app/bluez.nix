{ pkgs, lib, config, ... }: {

  options = {
    bluez.enable = lib.mkEnableOption "enables all dev chat apps";
  };

  config = lib.mkIf config.bluez.enable {
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
  };
}

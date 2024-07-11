{ pkgs, lib, config, ... }: {

  options = { android.enable = lib.mkEnableOption "enables dwm"; };

  config = lib.mkIf config.android.enable {
    programs.adb.enable = true;
    services.udev.packages = [ pkgs.android-udev-rules ];
    environment.systemPackages = with pkgs; [ android-studio androidSdk glibc ];
  };
}

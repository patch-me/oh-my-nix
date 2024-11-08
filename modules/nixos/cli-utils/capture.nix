{ pkgs, lib, config, ... }: {

  options = { cliTools.enable = lib.mkEnableOption "enables dwm"; };

  config = lib.mkIf config.cliTools.enable {
    environment.systemPackages = with pkgs; [ flameshot ];
  };
}

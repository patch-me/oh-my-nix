{ pkgs, lib, config, ... }: {
  options = {
    ventoy.enable = lib.mkEnableOption { description = "enable ventoy"; };
  };

  config = lib.mkIf config.ventoy.enable {
    environment.systemPackages = with pkgs; [ ventoy ];

  };
}

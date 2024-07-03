{ pkgs, lib, config, ... }: {

  options = {
    mail.enable = lib.mkEnableOption "enables all dev chat apps";
  };

  config = lib.mkIf config.mail.enable {
    environment.systemPackages = with pkgs; [
      thunderbird
    ];

  };
}

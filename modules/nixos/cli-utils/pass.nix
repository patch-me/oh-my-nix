{ pkgs, lib, config, ... }: {

  options = {
    pass.enable = lib.mkEnableOption "enables dwm";
  };

  config = lib.mkIf config.pass.enable {
    environment.systemPackages = with pkgs; [
      pass
    ];
    programs.gnupg.agent.enable = true;
  };
}

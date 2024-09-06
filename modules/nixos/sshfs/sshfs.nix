{ pkgs, lib, config, ... }: {

  options = { sshfs.enable = lib.mkEnableOption "enables dwm"; };

  config = lib.mkIf config.sshfs.enable { };
}

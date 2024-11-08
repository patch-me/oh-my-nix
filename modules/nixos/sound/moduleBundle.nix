{ pkgs, lib, config, ... }: {
  options.sound_driver = {
    enable = lib.mkEnableOption "Enables sound driver";
  };
  imports = [ ./pipewire.nix ];
}

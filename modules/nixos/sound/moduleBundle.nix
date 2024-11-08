{ pkgs, lib, config, ... }: {
  options.audioDriverConfig = {
    enable = lib.mkEnableOption "Enables the custom audio driver configuration";
  };

  config.audioDriverConfig.enable = true;

  imports = [ ./pipewire.nix ];
}

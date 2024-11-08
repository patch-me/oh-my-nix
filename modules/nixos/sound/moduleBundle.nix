{ pkgs, lib, config, ... }: {
  options = { sound.enable = lib.mkEnableOption "enables sound"; };
  imports = [ ./pipewire.nix ];
}

{ pkgs, lib, config, ... }: {

  options = { music.enable = lib.mkEnableOption "enables dwm"; };

  config = lib.mkIf config.music.enable {
    service.mpd = {
      enable = true;
      musicDirectory = "/home/brioche/music/";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';

      # Optional:
      network.listenAddress =
        "any"; # if you want to allow non-localhost connections
      startWhenNeeded =
        true; # systemd feature: only start MPD service upon connection to its socket
    };
  };
}

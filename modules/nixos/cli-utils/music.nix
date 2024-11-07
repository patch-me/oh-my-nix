{ pkgs, lib, config, ... }: {

  options = { music.enable = lib.mkEnableOption "enables dwm"; };

  config = lib.mkIf config.music.enable {
    # sound.enable = true;
    # hardware.pulseaudio.enable = true;
    services.mpd = {
      enable = true;
      user = "thomas";
      musicDirectory = "/home/thomas/music/";
      extraConfig = ''
        audio_output {
              type "pulse"
              name "My PulseAudio" # this can be whatever you want
        }
      '';
    };
    environment.systemPackages = with pkgs; [ mpc-cli ncmpcpp ];
  };
}

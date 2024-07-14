{ pkgs, lib, config, ... }: {

  options = { docker.enable = lib.mkEnableOption "enables dwm"; };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
      extraOptions = ''
        --insecure-registry "http://10.10.10.10:8082"
      '';
    };
    # security.pki.certificateFiles = [
    #   ./mycert.pem
    # ];

  };
}

{ pkgs, lib, config, ... }: {

  options = {
    docker.enable = lib.mkEnableOption "enables dwm";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker.enable = true;
    # security.pki.certificateFiles = [
    #   ./mycert.pem
    # ];

  };
}

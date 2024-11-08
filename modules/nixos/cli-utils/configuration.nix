{ pkgs, lib, config, ... }: {

  config = lib.mkIf config.cli-tools.enable {
    android.enable = true;
    docker.enable = true;
  };

}

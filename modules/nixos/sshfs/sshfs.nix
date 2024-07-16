{ pkgs, lib, config, ... }: {

  options = { sshfs.enable = lib.mkEnableOption "enables dwm"; };

  config = lib.mkIf config.sshfs.enable {
    fileSystems."/mnt/mypatch" = {
      device = "brioche@mypatch.fr:/";
      fsType = "sshfs";
      options =
        [ "nodev" "noatime" "allow_other" "IdentityFile=/root/.ssh/id_rsa" ];
    };
  };
}

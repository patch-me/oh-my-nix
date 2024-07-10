{ pkgs, lib, config, ... }: {
  options = { cli-tools.enable = lib.mkEnableOption "enables cli-tools"; };
  imports = [
    ./basic.nix
    ./docker.nix
    ./k8s.nix
    ./nvim.nix
    ./pass.nix

    ./code/rust.nix
    ./code/python.nix
    ./code/lua.nix
    ./ventoy.nix
  ];
}

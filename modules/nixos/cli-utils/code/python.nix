{ pkgs, lib, config, ... }: {

  environment.systemPackages = with pkgs; [
    python312
    python312Packages.nox
    python312Packages.virtualenv
    python312Packages.pip
  ];
}

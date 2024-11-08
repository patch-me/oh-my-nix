{ pkgs, lib, config, ... }: {

  environment.systemPackages = with pkgs; [
    (python312.withPackages
      (ps: with ps; [ pandas requests nox pip virtualenv pygments ]))
    poetry
  ];
}

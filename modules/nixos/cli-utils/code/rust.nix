{ pkgs, lib, config, ... }: {

  environment.systemPackages = with pkgs; [
    rustup
    stderred
    gcc
    clang
    cl
    zig
    nodejs_22
    pnpm
    ruby
    go
    php
    zulu17
    biber
    texliveFull
    luajitPackages.luarocks
    postgresql
    gnumake
    ripgrep
    haskellPackages.hoogle
    ast-grep
    rsync
    flameshot
  ];
}

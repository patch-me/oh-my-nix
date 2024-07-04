{ pkgs, lib, config, ... }: {

  environment.systemPackages = with pkgs; [
    luajitPackages.lua-lsp
  ];
}

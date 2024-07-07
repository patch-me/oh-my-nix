{ pkgs, lib, config, ... }: {

  environment.systemPackages = with pkgs; [
    luajitPackages.lua-lsp
    luajitPackages.jsregexp
    rust-analyzer
    ruff
    python312Packages.python-lsp-server
    nil
    black
    rustfmt
    stylua
    dockerfile-language-server-nodejs
    docker-compose-language-service
  ];
}

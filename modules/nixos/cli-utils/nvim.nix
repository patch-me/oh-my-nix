{ pkgs, lib, config, ... }: {
  options = {
    neovim.enable =
      lib.mkEnableOption { description = "enables dwm blocks for neovim"; };
  };

  config = lib.mkIf config.neovim.enable {
    environment.systemPackages = with pkgs; [ neovim ];

  };
}

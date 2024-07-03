{ pkgs, lib, config, ... }: {

	options = {
		dwm.enable=lib.mkEnableOption "enables dwm";
	};

	config = lib.mkIf config.dwm.enable {
		services.xserver.windowManager.dwm.enable=true;
		services.xserver.windowManager.dwm.package=pkgs.dwm.overrideAttrs {
			src=./dwm;
		};
        environment.systemPackages = with pkgs; [
            picom
            dmenu
            xclip
            clipmenu
            feh
            dwmblocks
        ];
    
	};
}

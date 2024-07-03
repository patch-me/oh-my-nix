{ pkgs, lib, config, ... }: {

	options = {
		supergfx.enable=lib.mkEnableOption "enables supergfxctl";
	};

	config = lib.mkIf config.supergfx.enable {
        environment.systemPackages = with pkgs; [
            supergfxctl
        ];
        services.supergfxd.enable=true;
    
	};
}

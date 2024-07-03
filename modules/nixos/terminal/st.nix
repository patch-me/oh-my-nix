{ pkgs, lib, config, ... }: {

	options = {
		st.enable=lib.mkEnableOption "enables st";
	};

	config = lib.mkIf config.st.enable {
        environment.systemPackages = [
            (pkgs.st.overrideAttrs ( attrs: {
                configFile = builtins.readFile ./st/config.def.h;
            }))
        ];
    
	};
}

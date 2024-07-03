{ pkgs, lib, config, ... }: {

	options = {
		k8s.enable=lib.mkEnableOption "enables dwm";
	};

	config = lib.mkIf config.k8s.enable {
        environment.systemPackages = with pkgs; [
            k9s
            helm
            kubectl

        ];
    
	};
}

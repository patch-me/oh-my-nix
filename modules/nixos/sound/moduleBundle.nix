{ pkgs, lib, config, ... }: {
	options = {
		cli-tools.enable=lib.mkEnableOption "enables cli-tools";
	};
	imports = [
        ./pipewire.nix
	];
}

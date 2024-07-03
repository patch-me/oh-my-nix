{ pkgs, lib, config, ... }: {

	imports = [
		./WM/moduleBundle.nix
		./terminal/moduleBundle.nix
        ./cli-utils/moduleBundle.nix
        ./app/moduleBundle.nix
        ./graphics/supergfctl.nix
        ./sound/moduleBundle.nix
	];
}

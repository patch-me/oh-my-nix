{ pkgs, lib, config, ... }: {

	options = {
		st.enable=lib.mkEnableOption "enables st";
	};

	config = lib.mkIf config.st.enable {
        environment.systemPackages = with pkgs; [
            (st.overrideAttrs (oldAttrs: rec {
              configFile = writeText "config.def.h" (builtins.readFile ./st/config.def.h);
              postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
            }))
            nerdfonts
            cascadia-code
        ];
        fonts.packages = with pkgs; [
          (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono"]; })
        ];
	};
}

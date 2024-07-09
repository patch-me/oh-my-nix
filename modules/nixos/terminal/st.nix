{ pkgs, lib, config, ... }: {

  options = { st.enable = lib.mkEnableOption "enables st"; };

  config = lib.mkIf config.st.enable {
    environment.systemPackages = with pkgs; [
      (st.overrideAttrs (oldAttrs: rec {
        src = ./st-flexipatch;
        postPatch = ''
          cp -r ${src}/* .
          ${oldAttrs.postPatch}
        '';
      }))
      st
      nerdfonts
      cascadia-code
    ];

    fonts.packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; }) ];
  };
}

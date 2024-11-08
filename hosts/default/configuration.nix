# Edit this configuration file to define what should be installed on
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixpkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/nixos/modules.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "biscuit"; # Define your hostname.
  networking.extraHosts = ''
    127.0.0.1 localhost.me
  '';

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    lc_address = "en_US.utf-8"; # Use US locale for address formatting
    lc_identification =
      "en_US.utf-8"; # Use US locale for identification formatting
    lc_measurement = "en_US.utf-8"; # Use US locale for measurement formatting
    lc_monetary = "en_US.utf-8"; # Use US locale for monetary formatting
    lc_name = "en_US.utf-8"; # Use US locale for name formatting
    lc_numeric = "en_US.utf-8"; # Use US locale for numeric formatting
    lc_paper = "en_US.utf-8"; # Use US locale for paper size (e.g., letter)
    lc_telephone =
      "en_US.utf-8"; # Use US locale for telephone number formatting
    lc_time = "en_US.utf-8"; # Use US locale for time formatting
  };

  # configure keymap in x11
  services.xserver = {
    xkb.layout = "us"; # Set X11 keymap to US layout
    xkb.variant = ""; # Use default variant for US layout
  };

  # configure console keymap
  console.keyMap = "us";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.thomas = {
    isNormalUser = true;
    description = "thomas";
    extraGroups =
      [ "networkmanager" "wheel" "docker" "disk" "storage" "kvm" "adbusers" ];
    packages = with pkgs; [ fish ];
    # shell = pkgs.fish;
  };
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    git
    udisks
    go-mtpfs
    jmtpfs
    usbutils
    glib
  ];
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # services.xserver.videoDrivers = ["nvidia"];
  #   hardware.nvidia = {
  #
  #   # Modesetting is required.
  #   modesetting.enable = true;
  #   powerManagement.enable = true;
  #   open = false;
  #   nvidiaSettings = true;
  #
  #   # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "thomas" = import ../../modules/home-manager/home.nix; };
  };
  WM.enable = true;
  dwm.enable = true;
  st.enable = true;
  cliTools.enable = true;
  firefox.enable = true;
  k8s.enable = true;
  supergfx.enable = false;
  pipewire.enable = true;
  neovim.enable = true;
  mail.enable = true;
  bluez.enable = true;
  pass.enable = true;
  ventoy.enable = false;
  music.enable = true;
  audioDriverConfig.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?

}

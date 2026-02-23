{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "hangocdinh-nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  services.automatic-timezoned.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.xserver.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.hangocdinh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    aria2
    mesa
    mesa-demos
    vulkan-tools
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.hangocdinh = ./home.nix;
  };

  services.openssh.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}


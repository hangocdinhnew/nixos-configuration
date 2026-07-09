{ config, lib, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  networking.hostName = "hangocdinh-nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  programs.nix-ld.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.xserver.enable = true;
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages: with python3Packages; [
      qtile-extras
    ];
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.automatic-timezoned.enable = true;

  systemd.oomd.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    mesa
    mesa.opencl
  ];
  
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    aria2
    mesa-demos
    vulkan-tools
    wlr-randr
    wl-clipboard
    xclip
    distrobox
  ];
  
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
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
  
  users.users.hangocdinh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
  };
  
  home-manager.users.hangocdinh = import ./home.nix;
  
  system.stateVersion = "25.11";
}
  

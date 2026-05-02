{ config, pkgs, ... }:

{
  home.username = "hangocdinh";
  home.homeDirectory = "/home/hangocdinh";
  
  imports = [
    ./modules/emacs.nix
    ./modules/wezterm.nix
    ./modules/zsh.nix
    ./modules/qtile.nix
  ];
  
  home.stateVersion = "24.05";
  
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    pkgs.nerd-fonts.hack    
    eza
    git
    lazygit
    gh
    wezterm
    devenv
    ripgrep
    grim
    krita
  ];
  
  home.sessionVariables = {
    EDITOR = "emacs";
  };
  
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        useGrimAdapter = true;
        disabledGrimWarning = true;
      };
    };
  };
  
  programs.home-manager.enable = true;
}

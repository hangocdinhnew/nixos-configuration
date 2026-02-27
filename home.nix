{ config, pkgs, ... }:

{
  home.username = "hangocdinh";
  home.homeDirectory = "/home/hangocdinh";
  
  imports = [
    ./modules/emacs.nix
    ./modules/wezterm.nix
    ./modules/zsh.nix
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
  ];
  
  home.sessionVariables = {
    EDITOR = "emacs";
  };
  
  programs.emacs.enable = true;
  programs.firefox.enable = true;
  
  programs.home-manager.enable = true;
}

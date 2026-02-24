{ config, pkgs, ... }:

{
  home.file."{config.xdg.configHome}/wezterm" = {
    source = ../config/wezterm;
    recursive = true;
  };
}

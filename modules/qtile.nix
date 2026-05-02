{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/qtile/config.py" = {
    source = ../config/qtile/config.py;
  };
}

{ config, pkgs, ... }:

{
  home.file.".emacs" = {
    source = ../config/emacs/.emacs;
  };

  home.file.".emacs.rc" = {
    source = ../config/emacs/.emacs.rc;
    recursive = true;
  };
}

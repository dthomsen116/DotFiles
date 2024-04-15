{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    name = "milktruck";
    homeDirectory = "/home/milktruck";
    stateVersion = "23.11"; # Please read the comment before changing.

    sessionVariables = {	

    };

    packages = [
        kitty
        zsh
      ];

    file = {
      };
    };
    programs.home-manager.enable = true;
  };
}

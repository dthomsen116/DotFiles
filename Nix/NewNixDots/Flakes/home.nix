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
    
        ".aliases" = {
          source = "github:/dthomsen116/DotFiles/Nix/NewNixDots/zsh/alias";
          };
        
        ".p10k.zsh" = {
          source = "github:/dthomsen116/DotFiles/Nix/NewNixDots/zsh/.p10k.zsh";
          executable = true;
        };
        
        ".zshrc" = {
          source = "github:/dthomsen116/DotFiles/Nix/NewNixDots/zsh/zshrc";
          executable = true;
        };
      };
    };
    programs.home-manager.enable = true;
  };
}

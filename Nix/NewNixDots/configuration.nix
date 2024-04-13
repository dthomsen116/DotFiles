# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


# Imports ===============================================
let
  user = "milktruck";
  hostname = "MilkOS";
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

# Bootloader/X11 ========================================
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
# Hostname/Networking ===================================
  networking = {
    hostName = "${hostname}"; # Define your hostname.
    networkmanager.enable = true;
	firewall.allowedTCPPorts = [22];
	firewall.allowedUDPPorts = [22];
  };

# Set your time zone. ===================================
  time.timeZone = "America/New_York";

# Select internationalisation properties. ===============
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

# Configure keymap in X11 =================================
  services = {

    xserver = {
      layout = "us";
      xkbVariant = "";
  };

    openssh = {
    enable = true;	
    };

};

# User ====================================================
  users.users.${user} = {
    isNormalUser = true;
    description = "Nixos Testing";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  
  users.defaultUserShell = pkgs.zsh;

# Allow unfree/insecure packages ===========================
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowInsecure = true;
    };
  };

# PROGRAMS =================================================
  programs = {

    hyprland = {
      enable = true;
      xwayland.enable = true;   
    };

     zsh = {
       enable = true;
       enableAutosuggestions = true;
       enableCompletion = true;
#       shellAliases = {
#               sm = "sudo micro";
#               e = "exit";
#               cls = "clear";
#               cs = "sudo nix-store --gc";
#               lg = "lazygit";
#               ll = "ls -l";
#               test = "sudo nixos-rebuild test";
#               edit = "sudo micro  /etc/nixos/configuration.nix";
#               update = "sudo nixos-rebuild switch";
#             };
       };
     
#PROGRAM END DONT DEL 
};

# HARDWARE =================================================
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

# SOUND ====================================================

  # Add user to the audio and video group.
  users.extraUsers.${user}.extraGroups = ["audio"];

  # Enable full Pulse Audio package
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
  #  support32Bit = true;
  };

# PACKAGES =================================================
  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

  
    
    systemPackages = with pkgs; [
  
      #Github
      git
      lazygit
      gh

      # Hyprland 
      hyprland
      swww
      xdg-desktop-portal-gtk
      xwayland

      # Terminal
      kitty
      zsh
      zplug
      micro
      
      # Web Browser
      firefox

      #Tools
      home-manager
      rofi
      pipewire

      #Fonra
      nerdfonts
      font-awesome
      
      quickemu

      ];
    };
## XDG ========================================================
  xdg.portal.enable = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "23.11"; # Did you read the comment?

}

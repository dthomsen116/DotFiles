# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


# Imports ===============================================
let
  user = "milktruck";
  hostname = "MilkOS";
in 
{
  imports =
    [
      ./hardware-configuration.nix
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
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

# User ====================================================
  users.users.${user} = {
    isNormalUser = true;
    description = "Nixos Testing";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

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
  };

# HARDWARE =================================================
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
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
      micro

      # Web Browser
      firefox
      
      ];
    };
## XDG ========================================================
  xdg.portal.enable = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "23.11"; # Did you read the comment?

}

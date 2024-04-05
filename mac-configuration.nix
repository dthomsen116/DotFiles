# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# Home Manager-Localizing and Imports (github.com/champpg)

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  user = "milktruck";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "MacNixOS"; # Define your hostname.

  boot.loader.efi.canTouchEfiVariables = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Budgie Desktop environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.budgie.enable = true;

  # X11 Vsync


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.milktruck = {
    isNormalUser = true;
    description = "MilkTruck";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    #Utils
    lf
    btop
    nmap
    curl
    bash
    wget
    unzip
    python3
        
    #Personal
    steam
    vivaldi
    discord
    spotify
    neofetch
    home-manager
    google-chrome
    mattermost-desktop
    whatsapp-for-linux

    #Apps
    gh
    git
    vim
    kitty
    lazygit
    wireshark
    libreoffice
    tty-solitaire

    #editors/terminal
    fish
    helix
    neovim
    bibata-cursors

    #TestEnv
    vitetris
    dmidecode
    asciiquarium
            
 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.


  home-manager.users.${user} = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */

  #KITTY KITTY KITTY
      programs.kitty = {
       enable = true;
       theme = "moonlight";
       shellIntegration.enableFishIntegration = true;
       settings = {
	 font_size = 12;
	 force_ltr = false;
	 disable_ligatures = "cursor";
         cursor_shape = "beam";
         cursor_blink_interval = 1;
         inactive_text_alpha = "0.8";
	 tab_bar_edge = "top";
	 tab_bar_style = "separator";
         sync_to_monitor = true;
	 shell = ".";
	 enable_audio_bell = false;
         cursor = "#fcfcfc";
      };
       extraConfig = "
	 map ctrl+right next_window
	 map ctrl+left previous_window
         map ctrl+shift+space next_layout
         map ctrl+; combine : clear_terminal scrollback active : send_text normal,application \x0c
       ";
    };


# home man end brackets
  };

     #all shells = fish
     programs.bash = {
       interactiveShellInit = ''
         if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
         then
           shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
           exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
         fi
       '';
     };

     #fish abbrs
     programs.fish = {
       enable = true;
       shellAbbrs = {
          e = "exit";
          la = "ls -a";
          cls = "clear";
          f = "asciiquarium";
          edit = "sudo nixos-rebuild edit";
          test = "sudo nixos-rebuild test";
          addboot = "sudo nixos-rebuild boot";
	  switch = "sudo nixos-rebuild switch";
          g = "sudo cp /etc/nixos/configuration.nix /home/${user}/NixOs/mac-configuration.nix"; 

        };
    };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

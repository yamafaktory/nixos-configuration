# yamafaktory - configuration.nix

{ config, pkgs, ... }:

{
  imports = [
    # Add hardware scan configuration.
    ./hardware-configuration.nix
    # Add environment settings.
    ./environment.nix
    # Add hosts.
    ./hosts.nix
    # Add packages.
    ./packages.nix
    # Add users.
    ./users.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira-mono
    ];
  };

  hardware = {
    bumblebee = {
      connectDisplay = true;
      enable = true;
    };
    cpu.intel.updateMicrocode = true;
    opengl = {
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiIntel ];
    };
    pulseaudio = {
      enable = true;
      systemWide = false;
    };
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_GB.UTF-8";
  };

  networking = {
    connman.enable = true;
    hostName = "nixos";
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
    wireless = {
      enable = true;
      networks = {
        yama = {};
      };
    };
  };

  nix = {
    extraOptions = ''
      build-cores = 4
    '';
    maxJobs = 4;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services = {
    journald = {
      extraConfig = ''
        SystemMaxUse=50M
      '';
    };
    xserver = {
      desktopManager = {
        default = "gnome3";
        gnome3.enable = true;
      };
      displayManager = {
        gdm.enable = true;
        sddm.autoNumlock = true;
        slim.defaultUser = "yamafaktory";
      };
      enable = true;
      layout = "gb";
      multitouch.enable = true;
      videoDrivers = [ "intel nvidia" ];
    };
  };

  system = {
    autoUpgrade = {
      channel= "https://nixos.org/channels/nixos-16.09";
      enable = true;
    };
    stateVersion = "16.09";
  };

  time.timeZone = "Europe/Paris";

  virtualisation.docker = {
    enable = true;
    socketActivation = true;
  };
}

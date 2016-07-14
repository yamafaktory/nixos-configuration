# yamafaktory - configuration.nix

{ config, pkgs, ... }:

{
  imports = [
    # Add hardware scan configuration.
    ./hardware-configuration.nix
    # Add hosts.
    ./hosts.nix
    # Add packages.
    ./packages.nix
    # Add users.
    ./users.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    gummiboot.enable = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira-mono
    ];
  };

  hardware = {
    bumblebee.enable = true;
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
      enable = true;
      desktopManager.gnome3.enable = true;
      layout = "gb";
      synaptics = {
        enable = true;
        twoFingerScroll = true;
      };
      videoDrivers = [ "intel" "nvidiaBeta" ];
      displayManager = {
        auto = {
          enable = true;
          user = "yamafaktory";
        };
        sddm.autoNumlock = true;
      };
    };
  };

  system = {
    autoUpgrade = {
      channel= "https://nixos.org/channels/nixos-16.03";
      enable = true;
    };
    stateVersion = "16.03";
  };

  systemd = {
    services.emacs.enable = true;
    user.services.emacs = {
      description = "Emacs Daemon";
      environment = {
        GTK_DATA_PREFIX = config.system.path;
        SSH_AUTH_SOCK = "%t/ssh-agent";
        GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
        NIX_PROFILES = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
        TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
        ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
      };
      serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.emacs}/bin/emacs-25pre --daemon";
        ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";
        Restart = "always";
      };
      wantedBy = [ "default.target" ];
    };
  };

  time.timeZone = "Europe/Paris";

  virtualisation.docker = {
    enable = true;
    socketActivation = false;
    storageDriver = "btrfs";
  };
}

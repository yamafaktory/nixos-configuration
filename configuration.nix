# yamafaktory - configuration.nix

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    gummiboot.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dropbox
    emacs25pre
    gimp
    git
    glxinfo
    gnumake
    google-chrome
    haskellPackages.stack
    nix-zsh-completions
    nodejs
    npm2nix
    openjdk8
    primus
    silver-searcher
    skype
    unrar
    vlc
    weechat
    wget
    xclip
    zip
    zsh
  ];

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
      };
    };
  };

  system.stateVersion = "16.03";

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
        ExecStart = "${pkgs.emacs}/bin/emacsemacs-25.0.92 --daemon";
        ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";
        Restart = "always";
      };
      wantedBy = [ "default.target" ];
    };
  };

  time.timeZone = "Europe/Paris";

  users.extraUsers.yamafaktory = {
    name = "yamafaktory";
    group = "users";
    extraGroups = [
      "audio"
      "bumblebee"
      "disk"
      "docker"
      "systemd-journal"
      "video"
      "wheel"
    ];
    createHome = true;
    home = "/home/yamafaktory";
    uid = 1000;
    isSystemUser = false;
    shell = "/run/current-system/sw/bin/zsh";
  };

  virtualisation.docker = {
    enable = true;
    socketActivation = false;
  };
}

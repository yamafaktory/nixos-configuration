# yamafaktory - users.nix

{ config, pkgs, ... }:

{
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
}

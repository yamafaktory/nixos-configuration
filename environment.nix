# yamafaktory - environment.nix

{ config, pkgs, ... }:

{
  environment.etc = {
    gitconfig.text = ''
      [user]
        email = yamafaktory@gmail.com
        name = yamafaktory
    '';

    "stack/config.yaml".text = ''
      nix:
        enable: true
    '';
  };
}
# yamafaktory - environment.nix

{ config, pkgs, ... }:

{
  environment = {
    etc = {
      gitconfig.text = ''
        [core]
          editor = emacs
        [user]
          email = yamafaktory@gmail.com
          name = yamafaktory
      '';

      "stack/config.yaml".text = ''
        nix:
          enable: true
          packages: [ ncurses ]
      '';
    };
    variables ={
      BROWSER = "google-chrome-stable";
    };
  };
}

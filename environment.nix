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
    };
    variables = {
      BROWSER = "google-chrome-stable";
    };
  };
}

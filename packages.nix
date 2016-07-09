# yamafaktory - packages.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
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
}

# yamafaktory - packages.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cabal2nix
    curl
    dropbox
    emacs
    gimp
    git
    glxinfo
    gnumake
    google-chrome
    htop
    nix-repl
    nix-zsh-completions
    npm2nix
    openjdk8
    primus
    silver-searcher
    skype
    stack
    tree
    unrar
    vlc
    weechat
    wget
    xclip
    zip
    zsh
  ];
}

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
    htop
    nix-repl
    nix-zsh-completions
    nodejs
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

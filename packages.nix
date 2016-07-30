# yamafaktory - packages.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    curl
    dropbox
    emacs25pre
    gimp
    git
    glxinfo
    gnumake
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

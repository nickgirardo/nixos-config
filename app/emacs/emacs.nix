{ pkgs, inputs, ... }:
{
  home.file.".emacs.d" = {
    source = ./emacs.d;
    recursive = true;
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;

    extraPackages = epkgs: [
      epkgs.evil
      epkgs.nix-mode
      epkgs.undo-tree
      epkgs.key-chord
      epkgs.git-gutter
    ];
  };
}

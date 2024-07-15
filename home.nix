{ config, pkgs, inputs, ... }:

{
  imports = [
    ./app/git.nix
    ./app/emacs/emacs.nix
    ./app/firefox.nix
    ./app/gnome_dconf.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nick";
  home.homeDirectory = "/home/nick";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # # I'm keeping this around as a quick sanity check that home.nix is active
    pkgs.hello

    pkgs.thunderbird

    pkgs.discord
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".inputrc".text = ''
      $include /etc/inputrc
      set completion-ignore-case on
      set show-all-if-ambiguous on
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nick/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "emacs";
    # Most apps should find default browser with xdg (configured below) but some use this envvar
    DEFAULT_BROWSER = "firefox";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      # git aliases
      "gs" = "git status";
      "gd" = "git diff -D";
      "gds" = "git diff -D --staged";
      "gdl" = "git diff HEAD~ HEAD";
      "gl" = "git -c color.ui=always log --oneline | head -20";
    };
  };

  # Set default programs for xdg respecting apps
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Web related mime types
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";

      # Use firefox as my pdf viewer
      "application/pdf" = "firefox.desktop";

      # Email related mime types
      "x-scheme-handler/mailto"="thunderbird.desktop";
      "message/rfc822"="thunderbird.desktop";
      "x-scheme-handler/mid"="thunderbird.desktop";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

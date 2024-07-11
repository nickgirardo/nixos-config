{ pkgs, inputs, ... }:
{
  # Gnome settings managed by dconf
  #
  # You can find which key corresponds to which feature by searching online a lot
  # But if you have the ability to change a setting in the GUI, you can do so
  # and check which key is updated with `dconf watch /`
  dconf.settings = {
    # Allow over-amplification
    # My laptop speakers are kinda weak so this is often necessary
    "org/gnome/desktop" ={
      allow-volume-above-100-percent = true;
    };

    # Set keyboard options
    # Using capslock as an extra ctrl key
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["terminate:ctrl_alt_bksp" "caps:ctrl_modifier"];
    };

    # This could be used to show gnome's activity display by moving a mouse to the top left corner
    # I see no need for this functionality so I've disabled it
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
    };

    # Allows moving windows in a tiling manner with <Super> and a direction
    "org/gnome/mutter" = {
      edge-tiling = true;
    };

    # Limit to one workspace, I don't find them useful
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 1;
    };

    # Switch windows with <Alt>Tab, switch apps with <Super>Tab
    "org/gnome/desktop/wm/keybindings" = {
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Set volume controls
      volume-mute = [ "AudioMute" ];
      volume-down = [ "AudioLowerVolume" ];
      volume-up = [ "AudioRaiseVolume" ];

      # Set referenences to custom keybindings
      # TODO check if they can/ should be named more descriptively
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    # <Super> + Key to open commonly used applications
    # For now just <Super>t to open a terminal, <Super>f to open firefox
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open Terminal";
      command = "kgx";
      binding = "<Super>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Open Firefox";
      command = "firefox";
      binding = "<Super>f";
    };
  };
}

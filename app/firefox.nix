{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nur.overlay
  ];
  # Maybe use browserpass?  Seems like it would be nice for this sort of setup
  programs.firefox = {
    enable = true;
    profiles.nick = {
      isDefault = true;
      bookmarks = { };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        privacy-badger
      ];
      search = {
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        force = true;
      };
      settings = {
        "accessibility.typeaheadfind.flashbar" = 0;

        "browser.contentblocking.category" = "standard";
        "browser.download.panel.shown" = true;
        "browser.newtappage.activity-stream.feeds.section.topstories" = false;
        "browser.newtappage.activity-stream.feeds.system.topstories" = false;
        "browser.newtappage.activity-stream.feeds.system.topsites" = false;
        "browser.newtappage.activity-stream.feeds.topsites" = false;
        "browser.toolbars.bookmarks.visibility" = "never";

        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.suggest.calculator" = true;
        # Pretty disgusting this even exists -_-
        "browser.urlbar.suggest.quicksuggest.sponsored" = true;

        "devtools.cache.disabled" = true;
        "devtools.command-button-measure.enabled" = true;
        "devtools.command-button-rulers.enabled" = true;
        "devtools.command-button-screenshot.enabled" = true;
        "devtools.everOpened" = true;

        "dom.security.https_only_mode" = true;

"extensions.pocket.enabled" = false;

        # WebGPU isn't supported on linux... but when it is I'll be ready!
        "dom.webgpu.enabled" = true;
        "dom.webgpu.indirect-dispatch.enabled" = true;

        # Enable middlemouse click for scroll
        "general.autoScroll" = true;

        "identity.fxaccounts.enabled" = false;

        "middlemouse.paste" = false;

        "privacy.trackingprotection.enabled" = true;
      };
    };
  };
}

{ pkgs, inputs, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Nick Girardo";
        email = "nickgirardo@gmail.com";
      };
      init.defaultBranch = "main";
    };

    lfs.enable = true;
  };
}

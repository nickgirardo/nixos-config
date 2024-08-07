{ pkgs, inputs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Nick Girardo";
    userEmail = "nickgirardo@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}

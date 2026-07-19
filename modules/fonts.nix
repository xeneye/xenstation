{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;

    hinting = {
      enable = true;
      autohint = true;
      style = "slight";
    };

    subpixel = {
      lcdfilter = "default";
      rgba = "none";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono
    roboto
    roboto-mono
  ];
}

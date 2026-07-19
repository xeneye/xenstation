{...}: {
  services.syncthing = {
    enable = true;

    user = "xeneye";
    dataDir = "/home/xeneye";
    configDir = "/home/xeneye/.config/syncthing";
  };
}

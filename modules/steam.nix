{pkgs, ...}: {
  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;

    extraCompatPackages = [
      pkgs.proton-ge-bin
      pkgs.proton-cachyos-v3
    ];

    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          keyutils
          libkrb5
          libusb1
          libXcomposite
          libXcursor
          libXdamage
          libXext
          libXi
          libXinerama
          libXrender
          libXScrnSaver
          SDL2
          udev
        ];
    };
  };

  environment.systemPackages = with pkgs; [
    mangohud
  ];
}

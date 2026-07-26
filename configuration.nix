{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/blender.nix
    ./modules/bluetooth.nix
    ./modules/boot.nix
    ./modules/docker.nix
    ./modules/fonts.nix
    ./modules/hue.nix
    ./modules/keymap.nix
    ./modules/lgtv.nix
    ./modules/nvidia.nix
    ./modules/obs.nix
    ./modules/packages.nix
    ./modules/pipewire.nix
    ./modules/printer.nix
    ./modules/steam.nix
    ./modules/syncthing.nix
    ./modules/vm.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    auto-optimise-store = true;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

#    max-jobs = 8;
#    cores = 0;

    substituters = [
      "https://cache.nixos.org"
      "https://cache.nixos-cuda.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  networking.hostName = "xenstation";
  networking.networkmanager.enable = true;

  programs.noisetorch.enable = true;

  programs.bash = {
    enable = true;
    completion.enable = true;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "xeneye";
  };

  services.fwupd.enable = true;
  services.hue.enable = true;
  services.tailscale.enable = true;

  services.fstrim = {
    enable = true;
    interval = "daily";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  users.users.xeneye = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "input"
      "kvm"
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    khelpcenter
    plasma-workspace-wallpapers
    qrca
  ];

  system.stateVersion = "26.05";
}

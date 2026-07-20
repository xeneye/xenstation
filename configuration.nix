{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/bluetooth.nix
    ./modules/boot.nix
    ./modules/docker.nix
    ./modules/fonts.nix
    ./modules/hue.nix
    ./modules/keymap.nix
    ./modules/nvidia.nix
    ./modules/packages.nix
    ./modules/pipewire.nix
    ./modules/printer.nix
    ./modules/steam.nix
    ./modules/syncthing.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
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

  services.fstrim.enable = true;
  services.fwupd.enable = true;
  services.hue.enable = true;
  services.tailscale.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  users.users.xeneye = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "input" "docker"];
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

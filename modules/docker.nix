{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker-compose
    lazydocker
    dive
    ctop
  ];
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;

    daemon.settings = {
      features = {
        buildkit = true;
        cdi = true;
      };

      log-driver = "json-file";
      log-opts = {
        max-size = "10m";
        max-file = "3";
      };
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
}

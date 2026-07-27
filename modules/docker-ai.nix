{pkgs, ...}: {
  systemd.services.docker-ai = {
    description = "Docker AI Stack";

    after = [
      "docker.service"
      "network-online.target"
    ];

    wants = [
      "network-online.target"
    ];

    requires = [
      "docker.service"
    ];

    wantedBy = [
      "multi-user.target"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "/etc/nixos/docker/ai";

      ExecStart = "${pkgs.docker}/bin/docker compose up -d";
      ExecStop = "${pkgs.docker}/bin/docker compose down";
    };
  };
}

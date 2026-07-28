{ pkgs, ... }:

{
  # Ensure the AI data directory exists and Hermes has the correct
  # ownership before the Docker stack starts.
  systemd.tmpfiles.rules = [
    # Root data directory
    "d /etc/nixos/docker/ai/data 0755 root root -"

    # Hermes persistent data
    "d /etc/nixos/docker/ai/data/hermes 0700 10000 10000 -"
  ];

  systemd.services.docker-ai = {
    description = "Docker AI Stack";

    after = [
      "docker.service"
      "network-online.target"
      "systemd-tmpfiles-setup.service"
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

      # Ensure restored or existing Hermes files always have the
      # ownership expected by the Hermes container.
      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -p /etc/nixos/docker/ai/data/hermes"
        "${pkgs.coreutils}/bin/chown -R 10000:10000 /etc/nixos/docker/ai/data/hermes"
        "${pkgs.coreutils}/bin/chmod 0700 /etc/nixos/docker/ai/data/hermes"
      ];

      ExecStart = "${pkgs.docker}/bin/docker compose up -d";
      ExecStop = "${pkgs.docker}/bin/docker compose down";
    };
  };
}

{pkgs, ...}: {
  systemd.tmpfiles.rules = [
    "d /etc/nixos/docker/ai/data 0755 root root -"
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

      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -p /etc/nixos/docker/ai/data/hermes"
        "${pkgs.coreutils}/bin/chown -R 10000:10000 /etc/nixos/docker/ai/data/hermes"
        "${pkgs.coreutils}/bin/chmod 0700 /etc/nixos/docker/ai/data/hermes"

        "${pkgs.bash}/bin/bash -c 'if [ ! -f /etc/nixos/docker/ai/data/hermes/config.yaml ]; then ${pkgs.coreutils}/bin/install -m 600 /etc/nixos/docker/ai/hermes-config.yaml /etc/nixos/docker/ai/data/hermes/config.yaml; fi'"
      ];

      ExecStart = "${pkgs.docker}/bin/docker compose up -d";
      ExecStop = "${pkgs.docker}/bin/docker compose down";
    };
  };

  systemd.services.docker-ai-ollama-pull = {
    description = "Pull default Ollama model";
    after = ["docker-ai.service"];
    requires = ["docker-ai.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "ollama-pull" ''
        until [ "$(${pkgs.docker}/bin/docker inspect --format='{{.State.Health.Status}}' ollama 2>/dev/null)" = "healthy" ]; do
        ${pkgs.coreutils}/bin/sleep 2
        done
        ${pkgs.docker}/bin/docker exec ollama ollama pull edtorre/gemma4:12b-agent-20gbGPU
      '';
    };
  };
}

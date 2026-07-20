{
  lib,
  pkgs,
  inputs,
  ...
}: let
  alga = inputs.alga.packages.${pkgs.system}.default;

  tv = "lgtv";
  input = "HDMI_2";

  lgtv-on = pkgs.writeShellScriptBin "lgtv-on" ''
    set -euo pipefail

    ${lib.getExe alga} --tv ${tv} power on

    for _ in $(seq 1 30); do
      if ${lib.getExe alga} --tv ${tv} input list >/dev/null 2>&1; then
        break
      fi
      sleep 1
    done

    ${lib.getExe alga} --tv ${tv} input set ${input}
  '';

  lgtv-off = pkgs.writeShellScriptBin "lgtv-off" ''
    set -euo pipefail

    ${lib.getExe alga} --tv ${tv} power off
  '';

  lgtv-toggle = pkgs.writeShellScriptBin "lgtv-toggle" ''
    set -euo pipefail

    if ${lib.getExe alga} --tv ${tv} input list >/dev/null 2>&1; then
      exec ${lib.getExe lgtv-off}
    else
      exec ${lib.getExe lgtv-on}
    fi
  '';
in {
  environment.systemPackages = [
    alga
    lgtv-on
    lgtv-off
    lgtv-toggle
  ];

  systemd.services.lgtv = {
    description = "LG TV lifecycle";

    wantedBy = ["multi-user.target"];

    wants = ["network-online.target"];
    after = ["network-online.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      User = "xeneye";
      Environment = "HOME=/home/xeneye";

      ExecStart = lib.getExe lgtv-on;
      ExecStop = lib.getExe lgtv-off;

      TimeoutStartSec = 45;
      TimeoutStopSec = 15;
    };
  };
}

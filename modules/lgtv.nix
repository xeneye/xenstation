# modules/lgtv.nix
{
  config,
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

    # Wait for the TV to become available.
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

  systemd.user.services.lgtv-on = {
    description = "Turn on LG TV at login";

    wantedBy = ["default.target"];

    after = ["graphical-session.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.getExe lgtv-on;
    };
  };

  systemd.services.lgtv-off = {
    description = "Turn off LG TV at shutdown";

    wantedBy = ["shutdown.target"];
    before = ["shutdown.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemd-inhibit --what=shutdown --mode=block ${lib.getExe lgtv-off}";
      TimeoutStartSec = 15;
    };
  };
}

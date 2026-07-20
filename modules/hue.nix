{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  # Machine-specific settings
  username = "xeneye";
  homeDir = "/home/${username}";

  roomId = "ef45f837-f248-43e7-8a4f-480d821f4dfa";
  roomName = "Man Cave";

  hue = pkgs.writeShellApplication {
    name = "hue";

    runtimeInputs = [
      pkgs.openhue-cli
      pkgs.jq
    ];

    text = ''
      set -euo pipefail

      ROOM_ID="${roomId}"
      ROOM_NAME="${roomName}"

      case "''${1:-}" in
        on)
          echo "Turning $ROOM_NAME lights on..."
          openhue set room "$ROOM_ID" --on >/dev/null
          ;;

        off)
          echo "Turning $ROOM_NAME lights off..."
          openhue set room "$ROOM_ID" --off >/dev/null
          ;;

        toggle)
          STATE=$(
            openhue get room --json \
              | jq -r '.[] | select(.Id=="'"$ROOM_ID"'") | .GroupedLight.HueData.on.on'
          )

          if [[ "$STATE" == "true" ]]; then
            echo "Turning $ROOM_NAME lights off..."
            openhue set room "$ROOM_ID" --off >/dev/null
          else
            echo "Turning $ROOM_NAME lights on..."
            openhue set room "$ROOM_ID" --on >/dev/null
          fi
          ;;

        *)
          echo "Usage: hue {on|off|toggle}"
          exit 1
          ;;
      esac
    '';
  };
in {
  options.services.hue = {
    enable = mkEnableOption "Man Cave Hue automation";
  };

  config = mkIf config.services.hue.enable {
    environment.systemPackages = [
      hue
    ];

    systemd.services.hue = {
      description = "Man Cave Hue Lights";

      wantedBy = ["multi-user.target"];

      wants = ["network-online.target"];
      after = ["network-online.target"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;

        User = username;
        Group = "users";

        Environment = [
          "HOME=${homeDir}"
        ];

        ExecStart = "${hue}/bin/hue on";
        ExecStop = "${hue}/bin/hue off";
      };
    };
  };
}

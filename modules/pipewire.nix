{lib, ...}: {
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;

    wireplumber.enable = true;
  };

  systemd.user.services.pipewire-pulse.serviceConfig.Environment = lib.mkAfter [
    "LADSPA_PATH=/tmp"
  ];
}

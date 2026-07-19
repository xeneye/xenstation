{pkgs, ...}: {
  imports = [
    ./modules/espanso.nix
    ./modules/fastfetch.nix
    ./modules/neovim.nix
    ./modules/starship.nix
  ];

  home.username = "xeneye";
  home.homeDirectory = "/home/xeneye";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    kdePackages.bluedevil
    kdePackages.kcolorchooser
    kdePackages.kate
    kdePackages.print-manager
    alejandra
    deadnix
    espanso-wayland
    eza
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Xeneye";
        email = "paul@xeneye.com";
      };
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
      alias = {
        st = "status";
        co = "checkout";
        ci = "commit";
        br = "branch";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      l = "eza -ls -CF";
      ll = "eza -lah --icons";
      la = "eza -a";
      lt = "eza --tree";
      nvim = "sudo -E nvim";
      vim = "sudo -E nvim";
      nv = "sudo -E nvim";
      aj = "sudo -E alejandra";
      dn = "sudo -E deadnix";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#xenstation";
      nx = "cd /etc/nixos";
    };
  };

  programs.home-manager.enable = true;

  systemd.user.services.noisetorch = {
    Unit = {
      Description = "NoiseTorch for Zoom H1";
      After = ["pipewire.service" "pipewire-pulse.service" "graphical-session.target"];
      Wants = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      RemainAfterExit = true;
      ExecStart = "${pkgs.noisetorch}/bin/noisetorch -s alsa_input.usb-ZOOM_Corporation_H1_000000000000-00.iec958-stereo -i -o";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}

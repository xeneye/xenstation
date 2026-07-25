{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;

    enableVirtualCamera = true;

    package = pkgs.obs-studio;

    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-move-transition
    ];
  };
}

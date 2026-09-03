{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;

    enableVirtualCamera = true;

    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      (obs-move-transition.overrideAttrs (oldAttrs: {
        NIX_CFLAGS_COMPILE = (oldAttrs.NIX_CFLAGS_COMPILE or "") + " -Wno-error=deprecated-declarations -Wno-deprecated-declarations";
        NIX_CXXFLAGS_COMPILE = (oldAttrs.NIX_CXXFLAGS_COMPILE or "") + " -Wno-error=deprecated-declarations -Wno-deprecated-declarations";
        cmakeFlags =
          (oldAttrs.cmakeFlags or [])
          ++ [
            "-DCMAKE_C_FLAGS=-Wno-error=deprecated-declarations"
            "-DCMAKE_CXX_FLAGS=-Wno-error=deprecated-declarations"
          ];
      }))
    ];
  };
}

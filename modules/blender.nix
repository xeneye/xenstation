{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

{pkgs, ...}: let
  username = "xeneye";
  vmHome = "/home/${username}/.vm";
in {
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  services.spice-vdagentd.enable = true;

  networking.firewall.trustedInterfaces = [
    "virbr0"
  ];

  services.udev.packages = with pkgs; [
    spice-gtk
  ];

  environment.systemPackages = with pkgs; [
    bridge-utils
    libguestfs
    qemu
    spice-gtk
    spice-vdagent
    usbredir
    usbutils
    virt-viewer
    virtio-win
  ];

  system.activationScripts.vmDirectories.text = ''
    install -d -o ${username} -g users -m755 ${vmHome}
    install -d -o ${username} -g users -m755 ${vmHome}/images
    install -d -o ${username} -g users -m755 ${vmHome}/isos
    install -d -o ${username} -g users -m755 ${vmHome}/exports
    install -d -o ${username} -g users -m755 ${vmHome}/snapshots
    install -d -o ${username} -g users -m755 ${vmHome}/scripts
  '';

  system.activationScripts.vmVirtioIso.text = ''
    ln -sfn \
      /run/current-system/sw/share/virtio-win/virtio-win.iso \
      ${vmHome}/isos/virtio-win.iso

    chown -h ${username}:users ${vmHome}/isos/virtio-win.iso || true
  '';
}

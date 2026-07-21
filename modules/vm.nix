{
  config,
  pkgs,
  ...
}: let
  username = "xeneye";
  group = "users";

  vmHome = "/home/${username}/.vm";

  poolName = "vm-images";
  poolPath = "${vmHome}/images";
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

  systemd.tmpfiles.rules = [
    "d ${vmHome} 0755 ${username} ${group} -"
    "d ${vmHome}/images 0755 ${username} ${group} -"
    "d ${vmHome}/isos 0755 ${username} ${group} -"
    "d ${vmHome}/exports 0755 ${username} ${group} -"
    "d ${vmHome}/snapshots 0755 ${username} ${group} -"
    "d ${vmHome}/scripts 0755 ${username} ${group} -"
  ];

  system.activationScripts.vmVirtioIso.text = ''
    ln -sfn \
      /run/current-system/sw/share/virtio-win/virtio-win.iso \
      ${vmHome}/isos/virtio-win.iso

    chown -h ${username}:${group} ${vmHome}/isos/virtio-win.iso || true
  '';

  systemd.services.libvirt-storage-pool = {
    description = "Ensure libvirt VM storage pool exists";

    after = ["libvirtd.service"];
    requires = ["libvirtd.service"];
    wantedBy = ["multi-user.target"];

    path = [
      pkgs.libvirt
    ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -euo pipefail

      if ! virsh pool-info ${poolName} >/dev/null 2>&1; then
        echo "Creating libvirt storage pool '${poolName}'"

        virsh pool-define-as \
          --name ${poolName} \
          --type dir \
          --target ${poolPath}
      fi

      virsh pool-start ${poolName} >/dev/null 2>&1 || true
      virsh pool-autostart ${poolName} >/dev/null 2>&1 || true
    '';
  };
}

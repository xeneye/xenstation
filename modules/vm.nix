{pkgs, ...}: let
  username = "xeneye";
  group = "users";

  vmHome = "/home/${username}/.vm";

  imagePoolName = "vm-images";
  imagePoolPath = "${vmHome}/images";

  isoPoolName = "vm-isos";
  isoPoolPath = "${vmHome}/isos";

  driversPoolName = "vm-drivers";
  driversPoolPath = "${vmHome}/drivers";
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
    qemu_kvm
    spice-gtk
    spice-vdagent
    usbredir
    usbutils
    virt-viewer
    virtio-win
  ];

  systemd.tmpfiles.rules = [
    "d ${vmHome} 0755 ${username} ${group} -"
    "d ${imagePoolPath} 0755 ${username} ${group} -"
    "d ${isoPoolPath} 0755 ${username} ${group} -"
    "d ${driversPoolPath} 0755 ${username} ${group} -"
    "d ${vmHome}/shared 0755 ${username} ${group} -"
    "d ${vmHome}/snapshots 0755 ${username} ${group} -"
    "d ${vmHome}/scripts 0755 ${username} ${group} -"
  ];

  system.activationScripts.vmVirtioDrivers.text = ''
    mkdir -p "${driversPoolPath}"

    # Remove anything currently in the directory.
    find "${driversPoolPath}" -mindepth 1 -maxdepth 1 \
      -exec rm -rf {} +

    # Populate it from the Nix store.
    for item in ${pkgs.virtio-win}/*; do
      ln -s "$item" "${driversPoolPath}/$(basename "$item")"
    done

    chown -h ${username}:${group} "${driversPoolPath}"/* 2>/dev/null || true
  '';

  systemd.services.libvirt-storage-pools = {
    description = "Ensure libvirt storage pools exist";

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

      create_pool() {
        local name="$1"
        local target="$2"

        mkdir -p "$target"

        if ! virsh -c qemu:///system pool-info "$name" >/dev/null 2>&1; then
          echo "Creating storage pool '$name'"

          virsh -c qemu:///system pool-define-as \
            --name "$name" \
            --type dir \
            --target "$target"
        fi

        virsh -c qemu:///system pool-build "$name" >/dev/null 2>&1 || true
        virsh -c qemu:///system pool-start "$name" >/dev/null 2>&1 || true
        virsh -c qemu:///system pool-autostart "$name" >/dev/null 2>&1 || true
      }

      create_pool "${imagePoolName}" "${imagePoolPath}"
      create_pool "${isoPoolName}" "${isoPoolPath}"
      create_pool "${driversPoolName}" "${driversPoolPath}"
    '';
  };
}

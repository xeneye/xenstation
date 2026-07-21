{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 0;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_level=3"
    "vt.global_cursor_default=0"
    "nowatchdog"
    "nmi_watchdog=0"
    "modprobe.blacklist=iTCO_wdt,iTCO_vendor_support,snd_hda_intel"
  ];

  boot.consoleLogLevel = 0;

  systemd.settings.Manager = {
    RuntimeWatchdogSec = "0";
    RebootWatchdogSec = "0";
    KExecWatchdogSec = "0";
  };

  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  boot.blacklistedKernelModules = [
    "snd_hda_intel"
    "iTCO_wdt"
    "iTCO_vendor_support"
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    priority = 5;
  };
}

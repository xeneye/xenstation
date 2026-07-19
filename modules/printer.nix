{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brlaser
    cups
    cups-brother-hll2375dw
    ipp-usb
    system-config-printer
  ];

  services.system-config-printer.enable = true;

  services.printing = {
    enable = true;
    drivers = [pkgs.brlaser];
  };
}

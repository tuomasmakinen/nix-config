{ ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "reboot=acpi" ];

  hardware.usb.wakeupDisabled = [
    {
      vendor = "046d";
      product = "c547";
    }
  ];
}

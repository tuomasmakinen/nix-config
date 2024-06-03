{ ... }:
{
  boot.kernelParams = [ "reboot=acpi" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.keyboard.qmk.enable = true;
  hardware.usb.wakeupDisabled = [
    {
      vendor = "046d";
      product = "c547";
    }
  ];
}

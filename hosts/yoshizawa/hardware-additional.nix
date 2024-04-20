{ ... }:
{

  boot.kernelParams = [ "reboot=acpi" ];

  hardware.usb.wakeupDisabled = [
    {
      vendor = "046d";
      product = "c547";
    }
  ];
}

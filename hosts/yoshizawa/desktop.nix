{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
    displayManager = {
      lightdm = {
        enable = true;
        greeters.slick = {
          enable = true;
          theme.name = "Nordic";
          theme.package = pkgs.nordic;
        };
      };
    };
    desktopManager.xfce = {
      enable = true;
      thunarPlugins = [ pkgs.xfce.thunar-archive-plugin ];
    };
    xrandrHeads = [
      { output = "DP-3"; }
      {
        output = "DP-2";
        primary = true;
      }
    ];
  };

  services.autorandr = {
    enable = true;
    profiles = {
      "default" = {
        fingerprint = {
          DP-2 = "00ffffffffffff0004722f05c4ad30742b1b0104a53c227806ee91a3544c99260f505421080001010101010101010101010101010101565e00a0a0a029503020350056502100001a000000ff0023415350706b346d7434794464000000fd001e9022de3b010a202020202020000000fc005842323731485520410a2020200106020312412309070183010000654b040001015a8700a0a0a03b503020350056502100001a5aa000a0a0a046503020350056502100001a6fc200a0a0a055503020350056502100001a22e50050a0a0675008203a0056502100001e1c2500a0a0a011503020350056502100001a0000000000000000000000000000000000000019";
          DP-3 = "00ffffffffffff0030aeec61000000000d1e0104a53c22783ab4a5ad4f449e250f5054a54b00d100d1c0b300714f81809500a9c0a9cf565e00a0a0a029503020350055502100001a000000fd00324c1e5a19010a202020202020000000fc004c454e20543237682d32300a20000000ff00564e4134443350480a2020202001d7020318f14b101f05140413121103020123097f0783010000f520a05050841a300820c80055502100001a0734805070381f400820180455502100001a6d24405060841a300820c80055502100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a1";
        };
        config = {
          DP-3 = {
            enable = true;
            position = "0x0";
            mode = "2560x1440";
          };
          DP-2 = {
            enable = true;
            primary = true;
            position = "2560x0";
            mode = "2560x1440";
            rate = "144.00";
          };
        };
      };
    };
  };
}

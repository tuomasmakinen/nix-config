{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    calibre-fixed = prev.calibre.override (old: {
      python3Packages = old.python3Packages // {
        mechanize = prev.python311Packages.mechanize.overridePythonAttrs (old: {
          doCheck = false;
        });
      };
    });
  };

  nur = inputs.nur.overlay;
}

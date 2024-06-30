{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Tuomas Mäkinen";
    userEmail = "28858039+t4sm5n@users.noreply.github.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
    ignores = [
      "*~"
      ".*.swp"
      ".DS_Store"
      ".[#~]*"
      ".idea/"
      "*.iml"
    ];
    diff-so-fancy.enable = true;
  };
}

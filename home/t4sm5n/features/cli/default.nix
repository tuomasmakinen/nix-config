{ pkgs, ... }: {
  home.packages = with pkgs; [
    jq
    yq

    nil
    nixfmt

    rustup
  ];

  programs = {
    git = {
      enable = true;
      userName = "t4sm5n";
      userEmail = "28858039+t4sm5n@users.noreply.github.com";
      extraConfig = { init = { defaultBranch = "main"; }; };
      diff-so-fancy.enable = true;
    };
    zoxide = { enable = true; };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableVteIntegration = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };
  };
}

{ config, ... }:
{
  age.secrets = {
    "restic/env".file = ./secrets/restic/env.age;
    "restic/repo".file = ./secrets/restic/repo.age;
    "restic/password".file = ./secrets/restic/password.age;
  };

  services.restic.backups = {
    daily = {
      initialize = true;

      environmentFile = config.age.secrets."restic/env".path;
      repositoryFile = config.age.secrets."restic/repo".path;
      passwordFile = config.age.secrets."restic/password".path;

      paths = [ "${config.users.users.t4sm5n.home}/Documents" ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };
}

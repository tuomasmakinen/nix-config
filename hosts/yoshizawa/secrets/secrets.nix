let
  t4sm5n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHITV+pHVxACLwqovX5DxcHHwLX2NGMNqk5WGjaPRZY t4sm5n@yoshizawa";
in
{
  "restic/env.age".publicKeys = [ t4sm5n ];
  "restic/repo.age".publicKeys = [ t4sm5n ];
  "restic/password.age".publicKeys = [ t4sm5n ];
}

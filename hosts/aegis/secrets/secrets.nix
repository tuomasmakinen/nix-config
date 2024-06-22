let
  t4sm5n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHITV+pHVxACLwqovX5DxcHHwLX2NGMNqk5WGjaPRZY t4sm5n@yoshizawa";
in
{
  "t4sm5n/password.age".publicKeys = [ t4sm5n ];
}

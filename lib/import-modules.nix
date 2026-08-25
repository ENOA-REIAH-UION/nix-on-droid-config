dir:
builtins.map
  (name: dir + "/${name}")
  (builtins.filter
    (name:
      let
        path = dir + "/${name}";
      in
        builtins.match ".*\\.nix" name != null
        && builtins.pathExists path
    )
    (builtins.attrNames (builtins.readDir dir)))
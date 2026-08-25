{ pkgs, ... }:

{
  environment.packages = with pkgs; [
    git
  ];

  environment.etc."gitconfig".text = ''
    [user]
      name = ENOA-REIAH-UION
      email = i@enoa.me

    [core]
      editor = nvim -f
      pager = nvim -R

    [color]
      pager = false

    [log]
      date = format:%Y-%m-%d %H:%M:%S

    [url "ssh://git@github.com/"]
      insteadOf = https://github.com/

    [url "ssh://git@gitlab.com/"]
      insteadOf = https://gitlab.com/
  '';
}

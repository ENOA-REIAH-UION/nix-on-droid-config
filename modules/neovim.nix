{ pkgs, ... }:

let
  inherit (pkgs)
    stdenvNoCC
    fetchurl
    lib
    autoPatchelfHook
    zlib;

  neovim-unwrapped = stdenvNoCC.mkDerivation {
    pname = "neovim-unwrapped";
    version = "0.12.4";

    src = fetchurl {
      url = "https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-arm64.tar.gz";
      sha256 = "ceb7e88c6b681f0515d135dcdfad54f5eb4373b25ce6172197cd9a69c758063f";
    };

    nativeBuildInputs = [ autoPatchelfHook ];

    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      zlib
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out
      tar -xzf $src -C $out --strip-components=1
    '';
  };

in {
  environment.packages = [
    neovim-unwrapped
    pkgs.tree-sitter
  ];
}
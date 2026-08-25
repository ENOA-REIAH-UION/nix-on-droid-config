{
  lib,
  stdenv,
  fetchgit,

  # nativeBuildInputs
  autoreconfHook,
  makeWrapper,
  pkg-config,
  texinfo,

  # buildInputs
  gnutls,
  harfbuzz,
  libxml2,
  ncurses,
  sqlite,
  tree-sitter,
  libgccjit,
  zlib,

  # optional
  mailutils,
}:

stdenv.mkDerivation rec {
  pname = "emacs";
  version = "31.1-rc1";

  src = fetchgit {
    url = "https://git.savannah.gnu.org/git/emacs.git";
    rev = "emacs-31.1-rc1";
    hash = "sha256-ZNCYFfMA2f14p57g/LdG6YK7nwUio8fdXmllkChMOSc=";
  };

  nativeBuildInputs = [
    makeWrapper
    pkg-config
    texinfo
    autoreconfHook
  ];

  buildInputs = [
    gnutls
    (lib.getDev harfbuzz)
    libxml2
    ncurses
    zlib
    libgccjit
    sqlite
    tree-sitter
  ];

  configureFlags = [
    (lib.enableFeature true "modules")
    (lib.enableFeature true "native-compilation")
    (lib.enableFeature true "tree-sitter")
    (lib.enableFeature true "sqlite3")
    (lib.enableFeature true "gnutls")

    # Nix-on-Droid：terminal-only
    (lib.withFeature false "x")
    (lib.withFeature false "pgtk")
    (lib.withFeature false "ns")
    (lib.withFeature false "xwidgets")
    (lib.withFeature false "gtk3")
    (lib.withFeature false "imagemagick")
    (lib.withFeature false "gpm")
  ];

  env = {
    NATIVE_FULL_AOT = "1";

    LIBRARY_PATH = lib.makeLibraryPath [
      libgccjit
      stdenv.cc.libc
    ];
  };

  enableParallelBuilding = true;

  installTargets = [
    "install"
  ];

  propagatedUserEnvPkgs = [
    mailutils
  ];

  doCheck = false;

  meta = {
    description = "Extensible, customizable GNU text editor";
    homepage = "https://www.gnu.org/software/emacs/";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    mainProgram = "emacs";
  };
}
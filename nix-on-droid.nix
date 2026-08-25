{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # Import modules
  imports = import ./lib/import-modules.nix ./modules;

  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    vim # or some other editor, e.g. nano or neovim

    claude-code
    
    patchelf
    autoPatchelfHook

    # androidenv.androidPkgs.emulator

    # Some common stuff that people expect to have
    procps
    #killall
    #diffutils
    #findutils
    #utillinux
    #tzdata
    #hostname
    #man
    gnugrep
    #gnupg
    gnused
    #gnutar
    #bzip2
    gzip
    xz
    #zip
    unzip
    gnutar
    openssh
    curl
    wget
    autoPatchelfHook
    diffutils
    
    # fcitx5-android build dependencies
    # kdePackages.extra-cmake-modules
    # gettext
    
    # emacs dependencies
    # (callPackage ./emacs.nix {})
    # cmigemo
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # 须先手动从旧世代中复制未损坏的 proot-static，https://github.com/nix-community/nix-on-droid/issues/519
  build.activation.zz_unfuck_proot = ''
    echo "overwriting proot-static.new with old (and working) proot executable"
    cp -v /data/data/com.termux.nix/files/usr/bin/proot-static /data/data/com.termux.nix/files/usr/bin/.proot-static.new
  '';

  # Hack: 让 bash 指向 sh，确保非 FHS 环境下 Claude CLI 能找到 POSIX shell
  build.activation.zz_unfuck_shell = ''
    if [ ! -e /data/data/com.termux.nix/files/usr/bin/bash ]; then
      echo "creating bash -> sh symlink for Claude CLI"
      ln -sf /data/data/com.termux.nix/files/usr/bin/sh /data/data/com.termux.nix/files/usr/bin/bash
    fi
  '';

  # extra-keys 等设置项非 termux-app(nix-on-droid-app) 主分支
  build.activation.termux-extra-keys = ''
    mkdir -p "$HOME/.termux"
    cat > "$HOME/.termux/termux.properties" <<'EOF'
extra-keys = [['ESC','TAB','CTRL','ALT','LEFT','UP','DOWN','RIGHT']]
extra-keys-button-text-color=#FFFFFF
extra-keys-button-active-text-color=#FF5555
extra-keys-button-background-color=#99000000
extra-keys-button-active-background-color=#444444
extra-keys-button-area-background-color=#00000000
extra-keys-button-gap=8
EOF
  '';

  build.activation.termux-color = ''
    mkdir -p "$HOME/.termux"
    cat > "$HOME/.termux/colors.properties" <<'EOF'
background=#23232F
cursor=#FFFFFF
foreground=#FFFFFF
# background-image=
background-alpha=0.8
EOF
  '';
  
  #  fcitx5-android build dependencies
	#  environment.sessionVariables = {
	#    ECM_DIR = "${pkgs.kdePackages.extra-cmake-modules}/share/ECM/cmake/";
	#  };

  # android-integration.unsupported.enable = true;
  android-integration.am.enable = true;
}

{ lib, pkgs, nu_scripts, ... }:

{
  user.shell = "${pkgs.nushell}/bin/nu";

  environment.packages = with pkgs; [
    nushell
    starship
  ];


  build.activation = {
    setup-nushell-config = ''
      mkdir -p "$HOME/.config/nushell"
      mkdir -p "$HOME/.config/nushell/aliases"
      cat > "$HOME/.config/nushell/aliases/gcloud.nu" << 'GCLOUD_EOF'
# Google Cloud CLI aliases
# Based on https://cloud.google.com/sdk/docs/configurations
# Note: Avoided conflicts with common git aliases (gc, gca, gcl, gcs, gcu, gs, etc.)

# Configuration management
export alias gccfg = gcloud config configurations create
export alias gcact = gcloud config configurations activate
export alias gclist = gcloud config configurations list
export alias gcdel = gcloud config configurations delete
export alias gcset = gcloud config set
export alias gcunset = gcloud config unset
export alias gcconfig = gcloud config list

# Authentication
export alias gclogin = gcloud auth login
export alias gcauth = gcloud auth list
export alias gcapp = gcloud auth application-default login

# Project management
export alias gcproj = gcloud config set project
export alias gcget = gcloud config get-value project

# Compute Engine
export alias gcinst = gcloud compute instances list
export alias gccreate = gcloud compute instances create
export alias gcdelete = gcloud compute instances delete
export alias gcssh = gcloud compute ssh
export alias gck8sget = gcloud container clusters get-credentials

# Storage
export alias gcst = gcloud storage
export alias gcstls = gcloud storage ls
export alias gcstcp = gcloud storage cp
export alias gcstrm = gcloud storage rm

# General shortcuts
# export alias gcloud = gcloud
export alias gcinfo = gcloud info
export alias gcver = gcloud version
GCLOUD_EOF
      cat > "$HOME/.config/nushell/config.nu" << 'EOF'
$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 5_000_000
$env.config.history.isolation = true
$env.config.show_banner = false
$env.config.rm.always_trash = true
$env.config.recursion_limit = 50
# $env.config.edit_mode = "vi"
$env.config.buffer_editor = ["nvim", "--clean"]
$env.config.cursor_shape.emacs = "inherit"
$env.config.cursor_shape.vi_insert = "block"
$env.config.cursor_shape.vi_normal = "underscore"
$env.config.use_kitty_protocol = false
$env.config.shell_integration.osc2 = true
$env.config.shell_integration.osc7 = true
$env.config.shell_integration.osc9_9 = false
$env.config.shell_integration.osc8 = true
$env.config.shell_integration.osc133 = true
$env.config.shell_integration.osc633 = true

const NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
    ($nu.data-dir | path join 'completions')
    "${nu_scripts.outPath}"
]

const NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

$env.CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1"
$env.CLAUDE_CODE_ATTRIBUTION_HEADER = "0"

use std/util "path add"
path add "~/.nix-profile/bin"
path add "~/.npm/bin"
path add "~/.cargo/bin"
path add "~/.gobin"
$env.PATH = ($env.PATH | uniq)

# -*- ssh-agent -*-
ssh-agent | lines | parse -r 'SSH_(?<k>[A-Z_]+)=(?<v>[^;]+)' | reduce -f {} {|it, acc| $acc | upsert $"SSH_($it.k)" $it.v } | load-env

# -*- completion -*-
use custom-completions/cargo/cargo-completions.nu *
use custom-completions/curl/curl-completions.nu *
use custom-completions/git/git-completions.nu *
use custom-completions/glow/glow-completions.nu *
use custom-completions/just/just-completions.nu *
use custom-completions/make/make-completions.nu *
use custom-completions/man/man-completions.nu *
use custom-completions/nix/nix-completions.nu *
use custom-completions/ssh/ssh-completions.nu *
use custom-completions/tar/tar-completions.nu *
use custom-completions/tcpdump/tcpdump-completions.nu *
use custom-completions/zellij/zellij-completions.nu *
use custom-completions/zoxide/zoxide-completions.nu *

# -*- alias -*-
use aliases/git/git-aliases.nu *
use aliases/eza/eza-aliases.nu *
use aliases/bat/bat-aliases.nu *
use ~/.config/nushell/aliases/gcloud.nu *

export alias vi = nvim

# -*- modules -*-
use modules/argx *
use modules/lg *
use modules/kubernetes *

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

EOF
    '';

    starship-config = ''
      mkdir -p "$HOME/.config"
      cat > "$HOME/.config/starship.toml" << 'EOF'
      "$schema" = 'https://starship.rs/config-schema.json'

      [kubernetes]
      symbol = "⛵"
      disabled = false

      [nodejs]
      disabled = true

      [python]
      disabled = true

      [java]
      disabled = true

      [rust]
      disabled = true

      [golang]
      disabled = true

      [kotlin]
      disabled = true

      [aws]
      disabled = true

      [gcloud]
      disabled = true

      [os]
      disabled = true

      [shell]
      disabled = true
      EOF
    '';
  };

  environment.sessionVariables.SHELL = "${pkgs.nushell}/bin/nu";
}

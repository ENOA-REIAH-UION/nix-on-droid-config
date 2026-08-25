{ lib, pkgs, ... }:

{
  environment.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";

  build.activation = {
    fish-init = ''
      mkdir -p "$HOME/.config/fish"

      sed -i '/starship init fish/d' "$HOME/.config/fish/config.fish" 2>/dev/null || true
      sed -i '/dircolors -c/d' "$HOME/.config/fish/config.fish" 2>/dev/null || true
      sed -i '/alias ls=/d' "$HOME/.config/fish/config.fish" 2>/dev/null || true
      sed -i '/alias grep=/d' "$HOME/.config/fish/config.fish" 2>/dev/null || true
      sed -i '/alias diff=/d' "$HOME/.config/fish/config.fish" 2>/dev/null || true

      # 颜色支持
      echo 'dircolors -c | source' >> "$HOME/.config/fish/config.fish"
      echo 'alias ls="ls --color=auto"' >> "$HOME/.config/fish/config.fish"
      echo 'alias grep="grep --color=auto"' >> "$HOME/.config/fish/config.fish"
      echo 'alias diff="diff --color=auto"' >> "$HOME/.config/fish/config.fish"

      # starship
      echo 'starship init fish | source' >> "$HOME/.config/fish/config.fish"
    '';

    starship-config = ''
      mkdir -p "$HOME/.config"
      cat > "$HOME/.config/starship.toml" << 'EOF'
      
      "$schema" = 'https://starship.rs/config-schema.json'
      
      format = """
      $username\
      $hostname\
      $directory\
      $git_branch\
      $git_state\
      $git_status\
      $cmd_duration\
      $line_break\
      $python\
      $character"""
      
      [directory]
      style = "blue"
      
      [character]
      success_symbol = "[❯](purple)"
      error_symbol = "[❯](red)"
      vimcmd_symbol = "[❮](green)"
      
      [git_branch]
      format = "[$branch]($style)"
      style = "bright-black"
      
      [git_status]
      format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)"
      style = "cyan"
      conflicted = "​"
      untracked = "​"
      modified = "​"
      staged = "​"
      renamed = "​"
      deleted = "​"
      stashed = "≡"
      
      [git_state]
      format = '\([$state( $progress_current/$progress_total)]($style)\) '
      style = "bright-black"
      
      [cmd_duration]
      format = "[$duration]($style) "
      style = "yellow"
      
      [python]
      format = "[$virtualenv]($style) "
      style = "bright-black"
      detect_extensions = []
      detect_files = []

      [localip]
      disabled = true
      [shlvl]
      disabled = true
      [singularity]
      disabled = true
      [kubernetes]
      disabled = true
      [vcsh]
      disabled = true
      [fossil_branch]
      disabled = true
      [fossil_metrics]
      disabled = true
      [git_commit]
      disabled = true
      [git_metrics]
      disabled = true
      [hg_branch]
      disabled = true
      [hg_state]
      disabled = true
      [pijul_channel]
      disabled = true
      [docker_context]
      disabled = true
      [package]
      disabled = true
      [c]
      disabled = true
      [cmake]
      disabled = true
      [cobol]
      disabled = true
      [daml]
      disabled = true
      [dart]
      disabled = true
      [deno]
      disabled = true
      [dotnet]
      disabled = true
      [elixir]
      disabled = true
      [elm]
      disabled = true
      [erlang]
      disabled = true
      [fennel]
      disabled = true
      [fortran]
      disabled = true
      [gleam]
      disabled = true
      [golang]
      disabled = true
      [guix_shell]
      disabled = true
      [haskell]
      disabled = true
      [haxe]
      disabled = true
      [helm]
      disabled = true
      [java]
      disabled = true
      [julia]
      disabled = true
      [kotlin]
      disabled = true
      [gradle]
      disabled = true
      [lua]
      disabled = true
      [nim]
      disabled = true
      [nodejs]
      disabled = true
      [ocaml]
      disabled = true
      [opa]
      disabled = true
      [perl]
      disabled = true
      [php]
      disabled = true
      [pulumi]
      disabled = true
      [purescript]
      disabled = true
      [quarto]
      disabled = true
      [raku]
      disabled = true
      [rlang]
      disabled = true
      [red]
      disabled = true
      [ruby]
      disabled = true
      [rust]
      disabled = true
      [scala]
      disabled = true
      [solidity]
      disabled = true
      [swift]
      disabled = true
      [terraform]
      disabled = true
      [typst]
      disabled = true
      [vlang]
      disabled = true
      [vagrant]
      disabled = true
      [zig]
      disabled = true
      [buf]
      disabled = true
      [nix_shell]
      disabled = true
      [conda]
      disabled = true
      [meson]
      disabled = true
      [spack]
      disabled = true
      [memory_usage]
      disabled = true
      [aws]
      disabled = true
      [gcloud]
      disabled = true
      [openstack]
      disabled = true
      [azure]
      disabled = true
      [nats]
      disabled = true
      [direnv]
      disabled = true
      [env_var]
      disabled = true
      [mise]
      disabled = true
      [crystal]
      disabled = true
      [custom]
      disabled = true
      [sudo]
      disabled = true
      [jobs]
      disabled = true
      [battery]
      disabled = true
      [time]
      disabled = true
      [status]
      disabled = true
      [os]
      disabled = true
      [container]
      disabled = true
      [netns]
      disabled = true
      [shell]
      disabled = true

      EOF
    '';
  };

  environment.packages = with pkgs; [
    fish
    starship
  ];
}


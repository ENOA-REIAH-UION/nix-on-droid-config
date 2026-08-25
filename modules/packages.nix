{
  pkgs,
  ...
}:
{
  environment.packages =
    with pkgs;
    (
      # -*- Data & Configuration Languages -*-#
      [
        #-- nix
        nil
        nixd
        statix # Lints and suggestions for the nix programming language
        deadnix # Find and remove unused code in .nix source files
        nixfmt # Nix Code Formatter

        #-- nickel lang
        nickel

        #-- json like
        taplo # TOML language server / formatter / validator
        yaml-language-server
        yamlfmt

        #-- markdown
        marksman # language server for markdown
        glow # markdown previewer
        pandoc # document converter
        hugo # static site generator
        actionlint # GitHub Actions linter

        #-- sql
        sqlfluff

        #-- protocol buffer
        buf # linting and formatting
      ]
      ++
        #-*- General Purpose Languages -*-#
        [
          #-- c/c++
          cmake
          cmake-language-server
          gnumake
          checkmake
          # c/c++ compiler, required by nvim-treesitter!
          gcc
          gdb
          # c/c++ tools with clang-tools, the unwrapped version won't
          # add alias like `cc` and `c++`, so that it won't conflict with gcc
          # llvmPackages.clang-unwrapped
          clang-tools
          lldb

          # fix: [nvim-treesitter/install] error: Error during "tree-sitter build":
          # tree-sitter

          #-- python
          uv # python project package manager
          pipx # Install and Run Python Applications in Isolated Environments
          (python313.withPackages (
            ps: with ps; [
              # python language server
              pyright
              ruff

              black # python formatter

              # my commonly used python packages
              jupyter
              ipython
              pandas
              requests
              pyquery
              pyyaml
              boto3

              # misc
              protobuf # protocol buffer compiler
              numpy
            ]
          ))

          #-- rust
          # we'd better use the rust-overlays for rust development
          rustc
          rust-analyzer
          cargo # rust package manager
          rustfmt
          clippy # rust linter

          #-- golang
          # go
          # gomodifytags
          # iferr # generate error handling code for go
          # impl # generate function implementation for go
          # # gotools # contains tools like: godoc, goimports, etc.
          # gopls # go language server
          # delve # go debugger

          # -- java
          jdk17
          gradle
          maven
          spring-boot-cli
          jdt-language-server

          kotlin-language-server
          ktlint

          #-- zig
          zls

          #-- lua
          stylua
          lua-language-server

          #-- haskell
          ghc
          cabal-install
          haskell-language-server
          haskellPackages.fourmolu

          #-- bash
          bash-language-server
          shellcheck
          shfmt
        ]
      #-*- Web Development -*-#
      ++ [
        nodejs_24
        pnpm
        typescript
        typescript-language-server
        # bun
        # # HTML/CSS/JSON/ESLint language servers extracted from vscode
        # vscode-langservers-extracted
        # tailwindcss-language-server
        # emmet-ls
      ]
      # -*- Lisp like Languages -*-#
      # ++ [
      #   guile
      #   racket-minimal
      #   fnlfmt # fennel
      #   (
      #     if pkgs.stdenv.isLinux && pkgs.stdenv.isx86
      #     then pkgs-master.akkuPackages.scheme-langserver
      #     else pkgs.emptyDirectory
      #   )
      # ]
      # ++ [
        # proselint # English prose linter

        # #-- verilog / systemverilog
        # verible

        # #-- Optional Requirements:
        # prettier # common code formatter
        # fzf
        # gdu # disk usage analyzer, required by AstroNvim
        # (ripgrep.override { withPCRE2 = true; }) # recursively searches directories for a regex pattern
      # ]
    );
}

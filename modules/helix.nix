{ pkgs, ... }:

{
  environment.packages = with pkgs; [
    helix
  ];

  build.activation = {
    helix-config = ''
      mkdir -p "$HOME/.config/helix"

      cat > "$HOME/.config/helix/config.toml" << 'EOF'
theme = "catppuccin_mocha"
[editor]
line-number = "relative"
cursorline = true
color-modes = true
scrolloff = 8

default-yank-register = "+"
auto-format = true
preview-completion-insert = true
completion-timeout = 5
idle-timeout = 200
end-of-line-diagnostics = "hint"

bufferline = "multiple"
popup-border = "menu"

[editor.soft-wrap]
enable = true

[editor.auto-save]
focus-lost = true

[editor.auto-save.after-delay]
enable = true
timeout = 2000

[editor.lsp]
display-messages = true
display-progress-messages = true
display-inlay-hints = true
auto-signature-help = true

[editor.inline-diagnostics]
cursor-line = "hint"
other-lines = "disable"

[editor.statusline]
left = [
  "mode",
  "spinner",
  "version-control",
  "file-name",
  "read-only-indicator",
  "file-modification-indicator",
]
center = []
right = [
  "workspace-diagnostics",
  "diagnostics",
  "selections",
  "position",
  "position-percentage",
  "file-type",
  "file-encoding",
  "file-line-ending",
]
separator = "│"
diagnostics = ["error", "warning", "info"]
workspace-diagnostics = ["error", "warning"]

[editor.statusline.mode]
normal = "NORMAL"
insert = "INSERT"
select = "SELECT"

[editor.file-picker]
hidden = false

[editor.cursor-shape]
insert = "bar"
normal = "block"
select = "underline"

[editor.indent-guides]
render = true

[keys.normal]
esc = "collapse_selection"
"$" = "goto_line_end"
"0" = "goto_line_start"
"C-S-o" = "jump_backward"

[keys.normal.space]
space = ":reload-all"
w = ":w"
q = ":q"

EOF

cat > "$HOME/.config/helix/languages.toml" << 'EOF'
[language-server.kotlin-language-server]
command = "kotlin-language-server"
timeout = 200

[[language]]
name = "kotlin"
language-servers = ["kotlin-language-server"]
file-types = ["kt", "kts"]
EOF
    '';
  };
}

{ config, pkgs, ... }:
{
  environment.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  terminal.font = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFontMono-Regular.ttf";
}
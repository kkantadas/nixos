{ config, pkgs, ... }:

{

imports = [
   ./modules/nvim.nix
   ./modules/suckless.nix
  ];

programs.bash = {
  enable = true;
  initExtra = ''
    source /home/kk/bin/dotfiles/.bashrc
  '';
};

  home.username = "kk";
  home.homeDirectory = "/home/kk";
  home.packages = with pkgs; [
     fzf
     eza
     lesspipe
     bat
     fzf 
     fd
     zoxide
     git
     fastfetch
     htop
     nerd-fonts.jetbrains-mono
  ];

 programs.ranger = {
    enable = true;
    extraPackages = with pkgs; [
      file
      highlight
      atool
      poppler-utils
      mediainfo
      ffmpegthumbnailer
    ];

    settings = {
      preview_images = true;
      unicode_ellipsis = false;
      draw_borders = false;
      show_hidden = true;
    };

    extraConfig = ''
      default_linemode devicons
      map DD shell gio trash %s
    '';

    plugins = [
      {
        name = "ranger_devicons";
        src = pkgs.fetchFromGitHub {
          owner = "alexanderjeurissen";
          repo = "ranger_devicons";
          rev = "master";
	  hash = "sha256-qvWqKVS4C5OO6bgETBlVDwcv4eamGlCUltjsBU3gAbA=";
        };
      }
    ];
  };

xdg.configFile."ranger/commands.py".text = ''
  from ranger.api.commands import Command

  class empty(Command):
      """:empty

      Empties the user trash directory.
      """

      def execute(self):
          self.fm.run("rm -rf /home/kk/.local/share/Trash/files/*")
          self.fm.notify("Trash emptied")
'';
  fonts.fontconfig.enable = true;
/*
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/kk/bin/dotfiles/.config/nvim/";
*/

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}

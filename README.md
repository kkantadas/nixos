Place the Application config dotfile folder with bashrc and nvim ... in ~/bin for homemanager!

Place this dotfiles with the nixos configuration in ~/ 

rebuild with:

$ sudo nixos-rebuild switch --flake ~/dotfiles/nixos#nixos-btw

suckless build:

navigate to the directory with the flake.nix 
and invoke the develop environment with:
$ nix develop .#suckless



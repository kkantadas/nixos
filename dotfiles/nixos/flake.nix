{ description = "kk first nixos system";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, ... }: 
    let 	
          system = "x86_64-linux";
          pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.suckless = pkgs.mkShell {
        # toolchain + headers/libs
        packages = with pkgs; [
          pkg-config
          libX11
          libXft
          libXinerama
          fontconfig
          freetype
          harfbuzz
          gcc
          gnumake
        ];

        shellHook = ''
          export PS1="\[\e[33m\][suckless-dev]\[\e[0m\] $PS1"
        '';
      };

  	nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
	         system = "x86_64-linux";
		modules = [ ./configuration.nix 
		home-manager.nixosModules.home-manager

		{
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.kk = import ./home.nix;
        }
      ];
    };
  };
 }

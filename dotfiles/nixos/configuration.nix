{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot = {
        enable = true;
	configurationLimit = 6;
     };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw"; # Define your hostname.
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Asia/Kolkata";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

   users.users.kk = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  services.xserver = {
     enable = true;
     autoRepeatDelay = 200;
      autoRepeatInterval = 35;
     displayManager.startx.enable = true;
     windowManager.dwm = {
       enable = true;
       package = pkgs.dwm.overrideAttrs {
          src = ./config/dwm;
     };
     };
     };

  home-manager.users.root = {
    imports = [
      ./modules/nvim.nix
    ];

    home.username = "root";
    home.homeDirectory = "/root";
    home.stateVersion = "26.05";
  };


   programs.firefox.enable = true;

   environment.defaultPackages = lib.mkForce [];
   environment.systemPackages = with pkgs; [
     xinit
     xsetroot
     st
     ];

     programs.nano.enable = false;

   services.openssh = {
     enable = true;
     settings.PasswordAuthentication = true;
     };

  system.stateVersion = "26.05"; 
}


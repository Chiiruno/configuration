# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
	system.stateVersion = "19.09";

	imports = [
		./boot.nix
		./hardware-configuration.nix
		./misc.nix
		./network.nix
		./override.nix
		./packages.nix
		./programs.nix
		./services.nix
	];

	nix = {
		useSandbox = true;
		autoOptimiseStore = true;
		buildCores = 0;
	};

	nixpkgs.config = {
		allowUnfree = true;
		pulseaudio = true;
		scream-receivers.pulseSupport = true;

		chromium = {
			enablePepperFlash = true;
			enableWideVine = true;
		};
	};

	users = {
		defaultUserShell = pkgs.zsh;

		extraUsers.okina = {
			isNormalUser = true;
			uid = 1000;
			home = "/home/okina";
			description = "隠岐奈";
			initialHashedPassword = "$6$2eZF5D9poF$0cDC37zn4bzmdiSZDsVIh1pqHjJov67N8GyTPUxgKMq6VOv/ahgr1657b3S/UxJm0p9KkYsbSFOGuBTSRSv6T0";
			extraGroups = [ "wheel" "kvm" "input" "libvirtd" ];
		};
	};
}

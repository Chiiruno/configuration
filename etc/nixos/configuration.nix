# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
	# Automatically upgrade the system.
	system.stateVersion = "unstable";

	# Import other configurations.
	imports = [
		<nixpkgs/nixos/modules/installer/scan/not-detected.nix>
		./boot.nix
		./misc.nix
		./mount.nix
		./network.nix
		./packages.nix
		./programs.nix
		./services.nix
	];

	# Nix configuration.
	nix = {
		maxJobs = 16;
		buildCores = 0;
		autoOptimiseStore = true;
		useSandbox = true;
	};

	# Nix packages configuration.
	nixpkgs.config = {
		allowUnfree = true;
		pulseaudio = true;
		icedtea = true;

		firefox = {
			enableGoogleTalkPlugin = true;
			enableAdobeFlash = true;
		};

		chromium = {
			enablePepperFlash = true;
			enablePepperPDF = true;
		};
	};

	# User configuration.
	users = {
		defaultUserShell = pkgs.zsh;

		extraUsers = {
			meguca.isSystemUser = true;
			hydron.isSystemUser = true;

			okina = {
				# $ mkpasswd -m sha-512
				initialHashedPassword = "$6$2eZF5D9poF$0cDC37zn4bzmdiSZDsVIh1pqHjJov67N8GyTPUxgKMq6VOv/ahgr1657b3S/UxJm0p9KkYsbSFOGuBTSRSv6T0";
				isNormalUser = true;
				uid = 1000;
				home = "/home/okina";
				description = "隠岐奈";

				extraGroups = [
					"wheel"
					"audio"
					"networkmanager"
					"input"
					"plugdev"
				];
			};
		};
	};
}

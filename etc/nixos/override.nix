let
	baseConfig = {
		allowUnfree = true;
		pulseaudio = true;
		firefox.enablePlasmaBrowserIntegration = true;
	};
	unstable = import <nixos-unstable> { config = baseConfig; };
in {
	imports = [ <nixos-unstable/nixos/modules/virtualisation/libvirtd.nix> ];
	disabledModules = [ "virtualisation/libvirtd.nix" ];

	nixpkgs.config = baseConfig // {
		packageOverrides = pkgs: {
			# Kernel
			linuxPackages_testing_bcachefs = unstable.linuxPackages_testing_bcachefs;
			bcachefs-tools = unstable.bcachefs-tools;

			# Development
			vscode-with-extensions = unstable.vscode-with-extensions;

			# Virtualization
			libvirt = unstable.libvirt;
			qemu = unstable.qemu;
			virt-manager = unstable.virt-manager;
			looking-glass-client = unstable.looking-glass-client;
			scream-receivers = unstable.scream-receivers;

			# Media
			youtube-dl = unstable.youtube-dl;
			discord = unstable.discord;
			steam = unstable.steam;
			firefox = unstable.firefox;
			konversation = unstable.konversation;
			ktorrent = unstable.ktorrent;
			ffmpeg-full = unstable.ffmpeg-full.override { rav1e = pkgs.rav1e; };
		};
	};
}

let
	unstable = import <nixos-unstable> { config = baseConfig; };

	baseConfig = {
		allowUnfree = true;
		pulseaudio = true;
		firefox.enablePlasmaBrowserIntegration = true;
	};
in {
	imports = [ <nixos-unstable/nixos/modules/virtualisation/libvirtd.nix> ];
	disabledModules = [ "virtualisation/libvirtd.nix" ];

	nixpkgs.config = baseConfig // {
		packageOverrides = pkgs: {
			# Kernel
			linuxPackages_testing_bcachefs = unstable.linuxPackages_testing_bcachefs;
			linux_testing_bcachefs = unstable.linux_testing_bcachefs;
			bcachefs-tools = unstable.bcachefs-tools;

			# Virtualization
			libvirt = unstable.libvirt;
			qemu = unstable.qemu;
		};
	};
}

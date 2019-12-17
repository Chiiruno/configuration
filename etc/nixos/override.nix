let
	baseConfig = { allowUnfree = true; };
	unstable = import <nixos-unstable> { config = baseConfig; };
in {
	imports = [ <nixos-unstable/nixos/modules/virtualisation/libvirtd.nix> ];
	disabledModules = [ "virtualisation/libvirtd.nix" ];

	nixpkgs.config = baseConfig // {
		packageOverrides = pkgs: {
			# Kernel
			linuxPackages_latest = unstable.linuxPackages_latest;

			# Development
			gcc = unstable.gcc;
			clang = unstable.clang;
			go = unstable.go;
			# tinygo = unstable.tinygo;
			vscode-with-extensions = unstable.vscode-with-extensions;

			# Virtualization
			libvirt = unstable.libvirt;
			qemu = unstable.qemu;
			virt-manager = unstable.virt-manager;
			win-qemu = unstable.win-qemu;

			# Media
			ffmpeg-full = unstable.ffmpeg-full;
			mixxx = unstable.mixxx;
		};
	};
}

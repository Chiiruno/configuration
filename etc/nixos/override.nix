let
	baseConfig = { allowUnfree = true; };
	unstable = import <nixos-unstable> { config = baseConfig; };
in {
	imports = [
		# <nixos-unstable/nixos/modules/virtualisation/libvirtd.nix>
		# <nixos-unstable/nixos/modules/services/web-servers/hydron.nix>
	];

	disabledModules = [
		# "virtualisation/libvirtd.nix"
		# "services/web-servers/hydron.nix"
	];

	nixpkgs.config = baseConfig // {
		packageOverrides = pkgs: {
			# Kernel
			linuxPackages_latest = unstable.linuxPackages_latest;

			# Development
			gcc = unstable.gcc;
			clang = unstable.clang;
			go = unstable.go;
			tinygo = unstable.tinygo;
			vscode-with-extensions = unstable.vscode-with-extensions;

			# Virtualization
			libvirt = unstable.libvirt;
			qemu = unstable.qemu;
			virt-manager = unstable.virt-manager;
			win-qemu = unstable.win-qemu;

			# Media
			ffmpeg-full = unstable.ffmpeg-full;
			mixxx = unstable.mixxx;
			hydron = unstable.hydron;
		};
	};
}

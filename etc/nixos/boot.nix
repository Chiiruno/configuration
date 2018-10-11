{ pkgs, ... }:

{
	# Boot configuration.
	boot = {
		plymouth.enable = true;
		kernelPackages = pkgs.linuxPackages_latest;
		kernelModules = [ "nct6775" ];

		kernelParams = [
			"amd_iommu=on"
			"iommu=pt"
			"zswap.enabled=1"
		];

		loader = {
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};

			grub = {
				efiSupport = true;
				enableCryptodisk = true;
				device = "nodev";
			};
		};

		initrd = {
			# Append root keyfile to initrd.
			secrets."/root/crypto/root.key" = /root/crypto/root.key;

			# Unlock the root partition.
			luks.devices."cryptroot" = {
				allowDiscards = true;
				keyFile = "/root/crypto/root.key";
			};
		};
	};
}

{ pkgs, ... }:

{
	# Boot configuration.
	boot = {
		# Kernel version to use.
		kernelPackages = pkgs.linuxPackages_latest;

		# Boot loader configuration.
		loader = {
			# EFI configuration.
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};

			# Use the GRUB boot loader.
			grub = {
				efiSupport = true;
				enableCryptodisk = true;
				device = "nodev";
			};
		};

		# Initial ram disk configuration.
		initrd = {
			# Append root keyfile to initrd.
			secrets."/root/crypto/root.key" = /root/crypto/root.key;

			# Available kernel modules for the initrd to mount root.
			availableKernelModules = [
				"nvme"
				"xhci_pci"
				"ahci"
				"usbhid"
				"usb_storage"
				"sd_mod"
			];

			# Unlock the root partition.
			luks.devices."cryptroot" = {
				allowDiscards = true;
				device = "/dev/disk/by-uuid/3d83d63f-449e-4e75-8225-dbba6fffa831";
				keyFile = "/root/crypto/root.key";
			};
		};

		# Kernel parameters.
		kernelParams = [
			"amd_iommu=on"
			"iommu=pt"
			"zswap.enabled=1"
		];

		# Enable the needed kernel modules.
		kernelModules = [
			"kvm-amd"
			"nct6775"
		];
	};
}

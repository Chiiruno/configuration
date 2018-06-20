{
	# Boot configuration.
	boot = {
		# Boot loader configuration.
		loader = {
			# EFI configuration.
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};

			# Use the GRUB boot loader.
			grub = {
				device = "nodev";
				efiSupport = true;
				enableCryptodisk = true;
				extraInitrd = "/root/crypto/root.cpio.gz";
			};
		};

		# Initial ram disk configuration.
		initrd = {
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
				device = "/dev/disk/by-uuid/3d83d63f-449e-4e75-8225-dbba6fffa831";
				allowDiscards = true;
				keyFile = "/root.key";
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

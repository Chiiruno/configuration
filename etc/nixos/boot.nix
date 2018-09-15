{ pkgs, ... }:

{
	# Boot configuration.
	boot = {
		# Linux kernel version to use.
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
			"vfio"
			"vfio_pci"
			"vfio_virqfd"
			"vfio_iommu_type1"
		];

		# Extra modprobe config.
		extraModprobeConfig = ''
			options vhost_net experimental_zcopytx=1
		'';
	};
}

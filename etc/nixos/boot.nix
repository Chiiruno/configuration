let
	key = "/etc/crypto/drive.key";
in {
	boot = {
#		plymouth.enable = true;
		kernelModules = [ "nct6775" ];
		supportedFilesystems = [ "bcachefs" ];

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
			# Append keyfile to initrd.
			secrets."/etc/crypto/drive.key" = /etc/crypto/drive.key;
			supportedFilesystems = [ "bcachefs" ];

			# Unlock the encrypted partitions.
			luks.devices = {
				"crypthdd0".keyFile = key;
				"crypthdd1".keyFile = key;

				"cryptboot" = {
					allowDiscards = true;
					keyFile = key;
				};

				"cryptswap" = {
					device = "/dev/disk/by-uuid/85396222-b178-49f1-92d2-76d0020a36e6";
					allowDiscards = true;
					keyFile = key;
				};

				"cryptroot" = {
					allowDiscards = true;
					keyFile = key;
				};

				"cryptssd0" = {
					allowDiscards = true;
					keyFile = key;
				};

				"cryptssd1" = {
					allowDiscards = true;
					keyFile = key;
				};
			};
		};
	};

	fileSystems = {
		"/".label = "root";
		"/mnt/ssd0".label = "ssd0";
		"/mnt/ssd1".label = "ssd1";
		"/mnt/hdd0".label = "hdd0";
		"/mnt/hdd1".label = "hdd1";

		"/boot" = {
			label = "boot";

			options = [
				"discard"
				"compress=lzo"
			];
		};

		"/boot/efi" = {
			label = "uefi";
			options = [ "discard" ];
		};
	};
}

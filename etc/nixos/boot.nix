let
	key = "/etc/crypto/drive.key";
in {
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
			# Append keyfiles to initrd.
			secrets."/etc/crypto/root.key" = /etc/crypto/root.key;
			secrets."/etc/crypto/drive.key" = /etc/crypto/drive.key;

			# Unlock the encrypted partitions.
			luks.devices = {
				"crypthdd0".keyFile = key;
				"crypthdd1".keyFile = key;

				"cryptswap" = {
					device = "/dev/disk/by-uuid/9666ab7d-6c7c-448f-8a34-8d0beefb055f";
					allowDiscards = true;
					keyFile = key;
				};

				"cryptroot" = {
					allowDiscards = true;
					keyFile = "/etc/crypto/root.key";
				};

				"cryptboot" = {
					allowDiscards = true;
					keyFile = key;
				};

				"cryptvirt" = {
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
		"/" = {
			label = "root";

			options = [
				"discard"
				"compress=zstd"
			];
		};

		"/.snapshots" = {
			label = "snapshots";

			options = [
				"discard"
				"compress=zstd"
			];
		};

		"/home" = {
			label = "home";

			options = [
				"discard"
				"compress=zstd"
			];
		};

		"/boot" = {
			label = "boot";

			options = [
				"discard"
				"compress=lzo"
			];
		};

		"/virt" = {
			label = "virt";

			options = [
				"discard"
				"nodatacow"
			];
		};

		"/boot/efi" = {
			label = "uefi";
			options = [ "discard" ];
		};

		"/mnt/ssd0" = {
			label = "ssd0";

			options = [
				"discard"
				"compress=zstd"
			];
		};

		"/mnt/ssd1" = {
			label = "ssd1";

			options = [
				"discard"
				"nodatacow"
			];
		};

		"/mnt/hdd0" = {
			label = "hdd0";
			options = [ "compress=zstd" ];
		};

		"/mnt/hdd1" = {
			label = "hdd1";
			options = [ "compress=zstd" ];
		};
	};
}

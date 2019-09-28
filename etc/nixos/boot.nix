{ pkgs, ... }:

let
	key = "/etc/crypto/drive.key";
in {
	swapDevices = [{ device = "/swap/swapfile"; }];

	boot = {
		plymouth.enable = true;
		kernelPackages = pkgs.linuxPackages_latest;
		kernelModules = [ "nct6775" ];

		kernelPatches = [{
			name = "enable-vfio";
			patch = null;

			extraConfig = ''
				VFIO y
				VFIO_PCI y
			'';
		}];

		kernelParams = [
			"amd_iommu=on"
			"iommu=pt"
			"zswap.enabled=1"
			"kvm.ignore_msrs=1"
			"vfio-pci.ids=1002:67df,1002:aaf0"
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
				splashImage = "/mnt/hdd1/home/okina/Pictures/grub.png";
			};
		};

		initrd = {
			# Append keyfiles to initrd.
			secrets."/etc/crypto/root.key" = /etc/crypto/root.key;
			secrets."/etc/crypto/drive.key" = /etc/crypto/drive.key;
			# Create /run/cryptsetup directory to avoid locking warning
			preDeviceCommands = "mkdir -pm0700 /run/cryptsetup";

			# Unlock the encrypted partitions.
			luks.devices = {
				"crypthdd0".keyFile = key;
				"crypthdd1".keyFile = key;
				"cryptwhdd0".keyFile = key;

				"cryptroot" = {
					allowDiscards = true;
					keyFile = "/etc/crypto/root.key";
				};

				"cryptssd0" = {
					allowDiscards = true;
					keyFile = key;
				};

				"cryptssd1" = {
					allowDiscards = true;
					keyFile = key;
				};

				"cryptwroot" = {
					allowDiscards = true;
					keyFile = key;
				};

				"cryptwssd0" = {
					allowDiscards = true;
					keyFile = key;
				};

				"cryptwssd1" = {
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
				"compress=lzo"
			];
		};

		"/.snapshots" = {
			label = "snapshots";

			options = [
				"discard"
				"compress=lzo"
			];
		};

		"/home" = {
			label = "home";

			options = [
				"discard"
				"compress=lzo"
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
				"compress=lzo"
			];
		};

		"/mnt/ssd1" = {
			label = "ssd1";

			options = [
				"discard"
				"compress=lzo"
			];
		};

		"/mnt/hdd0" = {
			label = "hdd0";
			options = [ "compress=lzo" ];
		};

		"/mnt/hdd1" = {
			label = "hdd1";
			options = [ "compress=lzo" ];
		};

		"/virt/root" = {
			label = "wroot";

			options = [
				"discard"
				"nodatacow"
			];
		};

		"/virt/ssd0" = {
			label = "wssd0";

			options = [
				"discard"
				"nodatacow"
			];
		};

		"/virt/ssd1" = {
			label = "wssd1";

			options = [
				"discard"
				"nodatacow"
			];
		};

		"/virt/hdd0" = {
			label = "whdd0";
			options = [ "nodatacow" ];
		};
	};
}

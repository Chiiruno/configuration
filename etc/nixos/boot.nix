{
	boot = {
		kernelModules = [ "k10temp" "nct6775" ];
		supportedFilesystems = [ "bcachefs" ];

		kernelParams = [
			"amd_iommu=on"
			"iommu=pt"
			"zswap.enabled=1"
			"default_hugepagesz=1G"
			"hugepagesz=1G"
			"hugepages=16"
		];

		kernel.sysctl = {
			"kernel.sysrq" = 1;
			"net.ipv6.conf.enp39s0.accept_ra" = 2;
			"net.ipv6.conf.virbr0.accept_ra" = 2;
			"net.ipv6.conf.macvtap0.accept_ra" = 2;
		};

		loader = {
			systemd-boot.enable = true;

			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};
		};

		initrd = {
			availableKernelModules = [ "amdgpu" "vfio-pci" ];
			supportedFilesystems = [ "bcachefs" ];

			preDeviceCommands = ''
				DEVS="0000:2d:00.0 0000:2d:00.1"

				for DEV in $DEVS; do
					echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
				done

				modprobe -i vfio-pci
			'';

			luks.devices = {
				"cryptroot".allowDiscards = true;
				"cryptssd0".allowDiscards = true;
				"cryptwhdd0".device = "/dev/disk/by-uuid/f1032f99-bebc-4984-92ad-0f2f3918eaf8";

				"cryptswap" = {
					device = "/dev/disk/by-uuid/218eaaeb-74bf-4d38-be49-a9098cd67f7e";
					allowDiscards = true;
				};

				"cryptwroot" = {
					device = "/dev/disk/by-uuid/2723e704-4a04-429b-981d-e52735304e78";
					allowDiscards = true;
				};

				"cryptwssd0" = {
					device = "/dev/disk/by-uuid/9877c16d-c375-48f3-9b69-006f4d509366";
					allowDiscards = true;
				};
			};
		};
	};

	fileSystems = {
		"/".label = "root";
		"/boot/efi".label = "uefi";
		"/mnt/ssd0".label = "ssd0";
		"/mnt/hdd0".label = "hdd0";
		"/mnt/hdd1".label = "hdd1";
	};
}

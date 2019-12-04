{ pkgs, ... }:

{
	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		kernelModules = [ "kvm-amd" "jc42" ];
		kernelParams = [ "amd_iommu=on" "iommu=pt" "kvm.ignore_msrs=1" "zswap.enabled=1" ];

		kernel.sysctl = {
			"net.ipv6.conf.enp39s0.accept_ra" = 2;
			"net.ipv6.conf.virbr0-nic.accept_ra" = 2;
		};

		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};

		initrd = {
			availableKernelModules = [ "amdgpu" "vfio-pci" ];

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
				"cryptwhdd0".device = "/dev/disk/by-uuid/9bdddd4a-c39c-4f60-9534-39758ee53d60";

				"cryptwroot" = {
					device = "/dev/disk/by-uuid/63e59147-896b-4141-9a21-fd3d86699ab2";
					allowDiscards = true;
				};

				"cryptwssd0" = {
					device = "/dev/disk/by-uuid/a84b909a-7edd-4334-9d91-f6d5bdf4c094";
					allowDiscards = true;
				};
			};
		};
	};

	fileSystems = {
		"/" = {
			label = "root";
			options = [ "noatime" "nodiratime" "discard" "autodefrag" "compress=zstd" ];
		};

		"/home" = {
			label = "home";
			options = [ "noatime" "nodiratime" "discard" "autodefrag" "compress=zstd" ];
		};

		"/boot" = {
			label = "boot";
			options = [ "noatime" "nodiratime" "discard" ];
		};

		"/mnt/ssd0" = {
			label = "ssd0";
			options = [ "noatime" "nodiratime" "discard" "autodefrag" "compress=zstd" ];
		};

		"/mnt/hdd0" = {
			label = "hdd0";
			options = [ "autodefrag" "compress=zstd" ];
		};

		"/mnt/hdd1" = {
			label = "hdd1";
			options = [ "autodefrag" "compress=zstd" ];
		};
	};

	swapDevices = [{
		device = "/swapfile";
		size = 8192;
	}];
}

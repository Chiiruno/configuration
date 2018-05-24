{
	# Enable the swap device.
	swapDevices = [{
		device = "/dev/disk/by-uuid/19de3cc5-84c2-4a7e-aae8-6e0a5af6d9da";

		encrypted = {
			enable = true;
			label = "cryptswap";
			blkDev = "/dev/disk/by-uuid/ccd8a7d9-994e-4306-bc50-378d7d0d5342";
			keyFile = "/mnt-root/root/crypto/swap.key";
		};
	}];

	# Unlock and set up filesystems.
	fileSystems = {
		# Root.
		"/" = {
			label = "root";
			device = "/dev/disk/by-uuid/b5b12b1b-c675-40e9-939a-9ab880cb4488";
			fsType = "btrfs";

			options = [
				"discard"
				"compress=lzo"
				"subvol=@"
			];
		};

		# Snapshots.
		"/.snapshots" = {
			label = "root";
			device = "/dev/disk/by-uuid/b5b12b1b-c675-40e9-939a-9ab880cb4488";
			fsType = "btrfs";

			options = [
				"discard"
				"compress=lzo"
				"subvol=@snapshots"
			];
		};

		# Home.
		"/home" = {
			label = "root";
			device = "/dev/disk/by-uuid/b5b12b1b-c675-40e9-939a-9ab880cb4488";
			fsType = "btrfs";

			options = [
				"discard"
				"compress=lzo"
				"subvol=@home"
			];
		};

		# Mount.
		"/mnt" = {
			label = "root";
			device = "/dev/disk/by-uuid/b5b12b1b-c675-40e9-939a-9ab880cb4488";
			fsType = "btrfs";

			options = [
				"discard"
				"compress=lzo"
				"subvol=@mnt"
			];
		};

		# EFI.
		"/boot/efi" = {
			label = "uefi";
			device = "/dev/disk/by-uuid/E3CC-991E";
			fsType = "vfat";
			options = ["discard"];
		};

		# SSD 0.
		"/mnt/ssd0" = {
			label = "ssd0";
			device = "/dev/disk/by-uuid/4176eb7d-65d2-4335-985c-fab68c3f254a";
			fsType = "btrfs";

			options = [
				"discard"
				"compress=lzo"
				"subvol=@ssd0"
			];


			encrypted = {
				enable = true;
				label = "cryptssd0";
				blkDev = "/dev/disk/by-uuid/e57dae01-19c9-4fc6-b1c6-f63fe650f613";
				keyFile = "/mnt-root/root/crypto/ssd0.key";
			};
		};

		# HDD 0.
		"/mnt/hdd0" = {
			label = "hdd0";
			device = "/dev/disk/by-uuid/2bebbd57-0784-44ba-b6c9-8b5a6958e8e7";
			fsType = "btrfs";

			options = [
				"discard"
				"compress=lzo"
				"subvol=@hdd0"
			];


			encrypted = {
				enable = true;
				label = "crypthdd0";
				blkDev = "/dev/disk/by-uuid/24cec112-fdf8-4ac4-a795-0585e5a19a97";
				keyFile = "/mnt-root/root/crypto/hdd0.key";
			};
		};

		# HDD 1.
		"/mnt/hdd1" = {
			label = "hdd1";
			device = "/dev/disk/by-uuid/7cbe8a84-63a2-4886-ab73-d755680fe35d";
			fsType = "btrfs";

			options = [
				"discard"
				"compress=lzo"
				"subvol=@hdd1"
			];

			encrypted = {
				enable = true;
				label = "crypthdd1";
				blkDev = "/dev/disk/by-uuid/2a1f756c-51bf-4259-bc6f-39334e407c44";
				keyFile = "/mnt-root/root/crypto/hdd1.key";
			};
		};
	};
}

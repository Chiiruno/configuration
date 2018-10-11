{
	swapDevices = [{
		device = "/dev/disk/by-uuid/19de3cc5-84c2-4a7e-aae8-6e0a5af6d9da";

		encrypted = {
			enable = true;
			label = "cryptswap";
			blkDev = "/dev/disk/by-uuid/ccd8a7d9-994e-4306-bc50-378d7d0d5342";
			keyFile = "/mnt-root/root/crypto/swap.key";
		};
	}];

	fileSystems = {
		"/" = {
			label = "root";

			options = [
				"discard"
				"compress=lzo"
			];
		};

		"/.snapshots" = {
			label = "root";

			options = [
				"discard"
				"compress=lzo"
			];
		};

		"/home" = {
			label = "root";

			options = [
				"discard"
				"compress=lzo"
			];
		};

		"/mnt" = {
			label = "root";

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

			encrypted = {
				enable = true;
				label = "cryptssd0";
				blkDev = "/dev/disk/by-uuid/e57dae01-19c9-4fc6-b1c6-f63fe650f613";
				keyFile = "/mnt-root/root/crypto/ssd0.key";
			};
		};

		"/mnt/hdd0" = {
			label = "hdd0";

			options = [
				"discard"
				"compress=lzo"
			];

			encrypted = {
				enable = true;
				label = "crypthdd0";
				blkDev = "/dev/disk/by-uuid/24cec112-fdf8-4ac4-a795-0585e5a19a97";
				keyFile = "/mnt-root/root/crypto/hdd0.key";
			};
		};

		"/mnt/hdd1" = {
			label = "hdd1";

			options = [
				"discard"
				"compress=lzo"
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

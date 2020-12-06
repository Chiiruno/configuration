{
	services = {
		timesyncd.enable = true;
		fstrim.enable = true;
		cron.enable = true;

		# Let users read GameCube and Wii controllers.
		udev.extraRules = ''
			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
			SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0aa7", TAG+="uaccess"
		'';

		# Ports: 9050, 9063, 8118
		tor = {
			enable = true;
			client.enable = true;
			torsocks.enable = true;
		};

#		zeronet = {
#			enable = true;
#			tor = true;
#			torAlways = true;
#		};

		mpd = {
			enable = true;
			user = "okina";
			group = "users";
			musicDirectory = "/mnt/hdd0/home/okina/Music";

			extraConfig = ''
				auto_update							"yes"
				max_playlist_length			"65536"
				max_command_list_size		"16384"
				max_output_buffer_size	"32768"

				audio_output {
					type		"pulse"
					name		"Pulseaudio"
					server	"127.0.0.1"
				}
			'';
		};

		xserver = {
			enable = true;
			layout = "us";
			desktopManager.plasma5.enable = true;

			displayManager.sddm = {
				enable = true;
				autoNumlock = true;
			};
		};
	};

	systemd.tmpfiles.rules = [
		"f /dev/shm/looking-glass 0660 okina libvirtd -"
		"f /dev/shm/scream-ivshmem 0660 okina libvirtd -"
	];
}

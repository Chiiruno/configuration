{ pkgs, ... }:

{
	services = {
		timesyncd.enable = true;
		printing.enable = true;
		samba.enable = true;
		accounts-daemon.enable = true;

		udev.extraRules = ''
			# Let users read GameCube and Wii controllers.
			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
			SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0aa7", TAG+="uaccess"
		'';

		# Ports: 9050, 9063, 8118
		tor = {
			enable = true;
			client.enable = true;
			torsocks.enable = true;
		};

		zeronet = {
			enable = true;
			tor = true;
			torAlways = true;
		};

		postgresql = {
			enable = true;
			package = pkgs.postgresql_11;
		};

		hydron = {
			enable = true;
			fetchTags = true;
			interval = "daily";
			importPaths = [ "/mnt/hdd1/home/okina/Pictures" ];
		};

		xserver = {
			enable = true;
			useGlamor = true;
			updateDbusEnvironment = true;
			desktopManager.plasma5.enable = true;
			layout = "us";

			displayManager.sddm = {
				enable = true;
				autoNumlock = true;
			};

			# Disable any joystick controlling the pointer.
			inputClassSections = [''
				Identifier		"joystick catchall"
				MatchIsJoystick	"on"
				MatchDevicePath	"/dev/input/event*"
				Driver			"joystick"
				Option			"StartKeysEnabled"  "False"	# Support
				Option			"StartMouseEnabled" "False"	# Disable the mouse
			''];
		};

		redshift = {
			enable = true;
			provider = "geoclue2";
		};
	};

	systemd = {
		services = {
			"looking-glass" = {
				description = "looking-glass shm";
				wantedBy = ["multi-user.target"];

				script = ''
					touch /dev/shm/looking-glass
					chown okina:kvm /dev/shm/looking-glass
					chmod 660 /dev/shm/looking-glass
				'';

				serviceConfig = {
					PermissionsStartOnly = true;
					Type = "oneshot";
				};
			};

		};

		user.services = {
			"timidity" = {
				description = "TiMidity++ Daemon";
				after = ["sound.target"];
				wantedBy = ["default.target"];
				serviceConfig.ExecStart = "${pkgs.timidity}/bin/timidity -iA -Os";
			};

			"mpd" = {
				description = "Music Player Daemon";
				after = [ "sound.target" ];
				wantedBy = ["default.target"];
				serviceConfig.ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon";
			};
		};
	};
}

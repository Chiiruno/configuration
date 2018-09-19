{ pkgs, ... }:

{
	services = {
		# Synchronize time.
		timesyncd.enable = true;

		# Enable printing support.
		printing.enable = true;

		# Enable Samba.
		samba.enable = true;

		# Enable TPM
#		tcsd.enable = true;

		# Enable GeoClue2
		geoclue2.enable = true;

		# Extra udev rules.
		udev.extraRules = ''
			# Let users read GameCube and Wii controllers.
			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
			SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0aa7", TAG+="uaccess"
		'';

		# Enable TOR.
		tor = {
			enable = true;	# 9050, 9063, 8118
			client.enable = true;
			torsocks.enable = true;
		};

		# Enable IPFS.
		ipfs = {
			enable = true;
			enableGC = true;
		};

		# Enable ZeroNet
		zeronet = {
			enable = true;
			tor = true;
			torAlways = true;
		};

		# Enable postgresql
		postgresql = {
			enable = true;
			package = pkgs.postgresql100;
		};

		# Enable hydron
		hydron = {
			enable = true;
			fetchTags = true;
			importPaths = [ "/mnt/hdd0/home/okina/Pictures" ];
		};

		# Enable the X11 server.
		xserver = {
			# Enable the X11 windowing system.
			enable = true;

			# Enable the KDE Desktop Environment.
			desktopManager.plasma5.enable = true;

			# Enable the display manager.
			displayManager.sddm = {
				enable = true;
				autoNumlock = true;
			};

			# Disable joystick controlling the pointer.
			inputClassSections = [''
				Identifier		"joystick catchall"
				MatchIsJoystick	"on"
				MatchDevicePath	"/dev/input/event*"
				Driver			"joystick"
				Option			"StartKeysEnabled" "False"	#Disable mouse
				Option			"StartMouseEnabled" "False"	#support
			''];
		};

		# Enable the redshift colour temperature changer.
		redshift = {
			enable = true;
			provider = "geoclue2";
		};
	};

	# Enable timidity service as user.
	systemd.user.services."timidity" = {
		description = "TiMidity++ Daemon";
		after = ["sound.target"];
		serviceConfig.ExecStart = "${pkgs.timidity}/bin/timidity -iA -Os";
		wantedBy = ["default.target"];
	};

	# Enable mpd service as user.
	systemd.user.services."mpd" = {
		description = "Music Player Daemon";
		after = [ "sound.target" ];
		serviceConfig.ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon";
		wantedBy = ["default.target"];
	};
}

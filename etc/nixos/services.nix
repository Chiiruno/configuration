{ pkgs, ... }:

{
	services = {
		# Synchronize time.
		timesyncd.enable = true;

		# Enable printing support.
		printing.enable = true;

		# Extra udev rules.
		udev.extraRules = ''
			# Let users read GameCube and Wii controllers.
			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
			SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0aa7", TAG+="uaccess"
		'';

		# Enable Prixoxy.
		privoxy = {
			enable = true;						# 8118

			extraConfig = ''
				forward-socks5 / 127.0.0.1:9063 .
				forward .i2p 127.0.0.1:4444
			'';
		};

		# Enable I2P.
		i2pd = {
			enable = true;
			bandwidth = 14000;
			enableIPv6 = true;
			port = 13372;
			upnp.enable = true;

			proto = {
				bob.enable = true;				# 2827
				http.enable = true;				# 7070
				httpProxy.enable = true;		# 4444
				i2cp.enable = true;				# 7654
				i2pControl.enable = true;		# 7650
				sam.enable = true;				# 7656
				socksProxy.enable = true;		# 4447
			};
		};

		# Enable TOR.
		tor = {
			enable = true;						# 9050, 9063, 8118
			client.enable = true;
			torsocks.enable = true;
		};

		# Enable IPFS.
		ipfs = {
			enable = true;
			enableGC = true;
		};

		# Enable ZeroNet
#		zeronet = {
#			enable = true;
#			tor = true;
#			port = 13375;
#		};

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

{ pkgs, ... }:

{
	services = {
		# Synchronize time.
		timesyncd.enable = true;

		# Enable printing support.
		printing.enable = true;

		# Enable postgresql
		postgresql.enable = true;

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
		};

		# Enable the redshift colour temperature changer.
		redshift = {
			enable = true;
			provider = "geoclue2";
		};

		# Enable the deluge daemon.
		deluge = {
			enable = true;
			openFilesLimit = 16384;
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

{ pkgs, ... }:

{
	services = {
		timesyncd.enable = true;
		printing.enable = true;
		samba.enable = true;
		accounts-daemon.enable = true;
		kbfs.enable = true;
		redshift.enable = true;

		udev.extraRules = ''
			# Let users read GameCube and Wii controllers.
			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
			SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0aa7", TAG+="uaccess"
		'';

		# DNS-over-TLS resolver
		stubby = {
			enable = true;
			listenAddresses = [ "127.0.0.1@53000" "0::1@53000" ];
			extraConfig = ''dnssec_trust_anchors: "/run/current-system/sw/share/dnsmasq/trust-anchors.conf"'';

			# Cloudflare DNS
			upstreamServers = ''
        - address_data: 1.1.1.1
          tls_auth_name: "cloudflare-dns.com"
        - address_data: 2606:4700:4700::1111
          tls_auth_name: "cloudflare-dns.com"
        - address_data: 1.0.0.1
          tls_auth_name: "cloudflare-dns.com"
        - address_data: 2606:4700:4700::1001
          tls_auth_name: "cloudflare-dns.com"
      '';
		};

		# Cache DNS data for DNS-over-TLS
		dnsmasq = {
			enable = true;
			servers = [ "::1#53000" "127.0.0.1#53000" ];

			extraConfig = ''
				no-resolv
				proxy-dnssec
				cache-size=1000
				listen-address=::1,127.0.0.1,192.168.1.1
			'';
		};

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

		hydron = {
			enable = true;
			fetchTags = true;
			interval = "daily";
			importPaths = [ "/mnt/hdd1/home/okina/Pictures" ];
		};

		xserver = {
			enable = true;
			updateDbusEnvironment = true;
			desktopManager.plasma5.enable = true;
			layout = "us";

			displayManager.sddm = {
				enable = true;
				autoNumlock = true;
			};

			# Disable any joystick controlling the pointer.
			inputClassSections = [''
				Identifier         "joystick catchall"
				MatchIsJoystick    "on"
				MatchDevicePath    "/dev/input/event*"
				Driver             "joystick"
				Option             "StartKeysEnabled"     "False"    # Support
				Option             "StartMouseEnabled"    "False"    # Disable the mouse
			''];
		};

		mpd = {
			enable = true;
			user = "okina";
			group = "users";
			musicDirectory = "/home/okina/Music";

			extraConfig = ''
				auto_update             "yes"

				max_playlist_length     "65536"
				max_command_list_size   "16384"
				max_output_buffer_size  "32768"

				follow_outside_symlinks "yes"
				follow_inside_symlinks  "yes"

				audio_output {
					type                  "pulse"
					name                  "Okina's Music Player Daemon"
					server                "127.0.0.1"
				}
			'';
		};
	};

	systemd = {
		services.nix-daemon.serviceConfig.EnvironmentFile = "/etc/github/credentials";

		user.services = {
			"timidity" = {
				description = "TiMidity++ Daemon";
				after = ["sound.target"];
				wantedBy = ["default.target"];
				unitConfig.ConditionUser = "okina";
				serviceConfig.ExecStart = "${pkgs.timidity}/bin/timidity -iA -Os";
			};
		};
	};
}

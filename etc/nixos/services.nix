{ pkgs, ... }:

{
	services = {
		timesyncd.enable = true;
		fstrim.enable = true;
		redshift.enable = true;
		kbfs.enable = true;

		# Scrub BTRFS filesystems monthly.
		btrfs.autoScrub = {
			enable = true;
			fileSystems = [ "/" "/home" "/mnt/ssd0" "/mnt/hdd0" "/mnt/hdd1" ];
		};

		# Let users read GameCube and Wii controllers.
		udev.extraRules = ''
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

		hydron = {
			enable = true;
			fetchTags = true;
			interval = "weekly";
			importPaths = [ "/mnt/hdd1/home/okina/Pictures" ];
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

		mpd = {
			enable = true;
			user = "okina";
			group = "users";
			musicDirectory = "/mnt/hdd1/home/okina/Music";

			extraConfig = ''
				auto_update             "yes"
				max_playlist_length     "65536"
				max_command_list_size   "16384"
				max_output_buffer_size  "32768"
				follow_outside_symlinks "yes"
				follow_inside_symlinks  "yes"

				audio_output {
					type   "pulse"
					name   "MPD"
					server "127.0.0.1"
				}
			'';
		};
	};

	systemd = {
		tmpfiles.rules = [ "f /dev/shm/scream 0660 okina libvirtd -" ];
		services.nix-daemon.serviceConfig.EnvironmentFile = "/etc/github/credentials";

		user.services.scream-ivshmem = {
			enable = true;
			description = "Scream IVSHMEM";
			wantedBy = [ "multi-user.target" ];
			requires = [ "pulseaudio.service" ];

			serviceConfig = {
				ExecStartPre = "${pkgs.coreutils}/bin/dd if=/dev/zero of=/dev/shm/scream bs=1M count=2";
				ExecStart = "${pkgs.scream-receivers}/bin/scream-ivshmem-pulse /dev/shm/scream";
				Restart = "always";
			};
		};
	};
}

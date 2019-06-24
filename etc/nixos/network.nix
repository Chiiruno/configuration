{
	networking = {
		hostName = "okinan";
		nameservers = [ "127.0.0.1" "::1" ];

		networkmanager = {
			enable = true;
			dns = "none";
		};

		firewall = {
			allowedTCPPorts = [
				# Torrent
				13370
			];

			allowedUDPPorts = [
				# Torrent
				13370
			];
		};
	};
}

{
	networking = {
		hostName = "okinan";
		networkmanager.enable = true;

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

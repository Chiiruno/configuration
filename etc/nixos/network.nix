{
	networking = {
		networkmanager.enable = true;
		hostName = "okinan";

		firewall = {
			allowedTCPPorts = [
				# Torrent
				13370

				# Barrier
				24800
			];

			allowedUDPPorts = [
				# Torrent
				13370

				# Barrier
				24800
			];
		};
	};
}

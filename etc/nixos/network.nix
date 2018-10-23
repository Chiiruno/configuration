{
	networking = {
		networkmanager.enable = true;
		hostName = "okinan";

		firewall = {
			allowedTCPPorts = [
				# Torrent
				13370

				# Risk of Rain
				13379

				# ZeroNet
				15441
			];

			allowedUDPPorts = [
				# Torrent
				13370

				# Risk of Rain
				13379

				# ZeroNet
				15441
			];

			extraCommands = ''
				iptables -A INPUT -p ipv6-icmp -j ACCEPT
			'';
		};
	};
}

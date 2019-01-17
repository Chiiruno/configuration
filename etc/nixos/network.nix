{
	networking = {
		networkmanager.enable = true;
		hostName = "okinan";

		firewall = {
			allowedTCPPorts = [
				# Torrent
				13370
			];

			allowedUDPPorts = [
				# Torrent
				13370
			];

			extraCommands = ''
				iptables -A INPUT -p ipv6-icmp -j ACCEPT
			'';
		};
	};
}

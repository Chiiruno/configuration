{
	# Networking configuration.
	networking = {
		hostName = "okinan";
		networkmanager.enable = true;

		firewall = {
			# Allow connections from certain ports (TCP).
			allowedTCPPorts = [
				# Torrent
				13370

				# ZeroNet
				15441
			];

			# Allow connections from certain ports (UDP).
			allowedUDPPorts = [
				# Torrent
				13370

				# ZeroNet
				15441
			];

			# Extra firewall commands
			extraCommands = ''
				iptables -A INPUT -p ipv6-icmp -j ACCEPT
			'';
		};
	};
}

{
	# Networking configuration.
	networking = {
		hostName = "okinan";
		networkmanager.enable = true;

		firewall = {
			# Allow connections from certain ports (TCP).
			allowedTCPPorts = [
				# Besiege
				7777

				# Perfect Dark
				13371

				# I2P
				13372

				# Risk of Rain
				13373

				# Torrent
				13374
			];

			# Allow connections from certain ports (UDP).
			allowedUDPPorts = [
				# Besiege
				7777

				# I2P
				13372

				# Risk of Rain
				13373

				# Torrent
				13374
			];

			# Extra firewall commands
			extraCommands = ''
				iptables -A INPUT -p ipv6-icmp -j ACCEPT
			'';
		};
	};
}

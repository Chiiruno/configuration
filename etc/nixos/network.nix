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
			];

			# Allow connections from certain port ranges (TCP).
			allowedTCPPortRanges = [
				# Deluge
				{ from = 6881; to = 6889; }
			];

			# Allow connections from certain ports (UDP).
			allowedUDPPorts = [
				# Besiege
				7777

				# I2P
				13372

				# Risk of Rain
				13373
			];

			# Allow connections from certain port ranges (UDP).
			allowedUDPPortRanges = [
				# Deluge
				{ from = 6881; to = 6889; }
			];

			# Extra firewall commands
			extraCommands = ''
				iptables -A INPUT -p ipv6-icmp -j ACCEPT
			'';
		};
	};
}

{
	# Networking configuration.
	networking = {
		hostName = "okinan";
		networkmanager.enable = true;

		# Allow connections from certain ports (TCP).
		firewall.allowedTCPPorts = [
			# Perfect Dark
			13371

			# I2P
			13372
		];

		# Allow connections from certain port ranges (TCP).
		firewall.allowedTCPPortRanges = [
			# Deluge
			{ from = 6881; to = 6889; }
		];

		# Allow connections from certain ports (UDP).
		firewall.allowedUDPPorts = [
			# I2P
			13372
		];

		# Allow connections from certain port ranges (UDP).
		firewall.allowedUDPPortRanges = [
			# Deluge
			{ from = 6881; to = 6889; }
		];
	};
}

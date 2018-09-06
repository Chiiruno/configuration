{ pkgs, ... }:

{
	# Use the "ondemand" CPU frequency governor.
	powerManagement.cpuFreqGovernor = "ondemand";

	# Set your time zone.
	time.timeZone = "America/Chicago";

	# Set limits for esync.
	systemd.extraConfig = "DefaultLimitNOFILE=1048576";

	security.pam.loginLimits = [{
		domain = "*";
		type = "hard";
		item = "nofile";
		value = "1048576";
	}];

	# Hardware configuration.
	hardware = {
		# Enable updating the AMD microcode.
		cpu.amd.updateMicrocode = true;

		# Enable bluetooth.
		bluetooth.enable = true;

		# OpenGL configuration.
		opengl = {
			driSupport32Bit = true;
			s3tcSupport = true;
		};

		# Enable PulseAudio support.
		pulseaudio = {
			enable = true;
			support32Bit = true;
		};
	};

	# Font configuration.
	fonts = {
		fontconfig.cache32Bit = true;

		fonts = with pkgs; [
			dejavu_fonts
			ipafont
		];
	};
}

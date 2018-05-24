{ pkgs, ... }:

{
	# Use the "ondemand" CPU frequency governor.
	powerManagement.cpuFreqGovernor = "ondemand";

	# Set your time zone.
	time.timeZone = "America/Chicago";

	# Hardware configuration.
	hardware = {
		# Enable updating the AMD microcode.
		cpu.amd.updateMicrocode = true;

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

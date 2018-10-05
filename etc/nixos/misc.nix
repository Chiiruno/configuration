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

	# Virtualization configuration.
	virtualisation.libvirtd = {
		enable = true;

		qemuVerbatimConfig = ''
			namespaces = []
			user = "okina"
			nographics_allow_host_audio = 1
			max_files = 2048
		'';
	};

	# Hardware configuration.
	hardware = {
		# Enable updating the AMD microcode.
		cpu.amd.updateMicrocode = true;

		# Enable bluetooth.
		bluetooth.enable = true;

		# Enable Steam controllers.
		steam-hardware.enable = true;

		# OpenGL configuration.
		opengl = {
			driSupport32Bit = true;
			s3tcSupport = true;
		};

		# Enable PulseAudio support.
		pulseaudio = {
			enable = true;
			support32Bit = true;
			package = pkgs.pulseaudioFull;

			daemon.config = {
				default-sample-format = "s32le";
				default-sample-rate = "96000";
				resample-method = "speex-float-5";
			};
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

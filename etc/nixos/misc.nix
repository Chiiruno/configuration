{ pkgs, ... }:

{
	time.timeZone = "America/Chicago";
	systemd.extraConfig = "DefaultLimitNOFILE=1048576";
	sound.enable = true;

	security.pam.loginLimits = [{
		domain = "*";
		type = "hard";
		item = "nofile";
		value = "1048576";
	}];

	virtualisation.libvirtd = {
		enable = true;

		qemuVerbatimConfig = ''
			namespaces = []
			user = "okina"
			nographics_allow_host_audio = 1
			max_files = 2048
		'';
	};

	hardware = {
		cpu.amd.updateMicrocode = true;
		bluetooth.enable = true;
		steam-hardware.enable = true;

		opengl = {
			driSupport32Bit = true;
			s3tcSupport = true;
		};

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

	fonts = {
		fontconfig.cache32Bit = true;
		fonts = with pkgs; [ ipafont ];
	};
}

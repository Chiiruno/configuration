{ pkgs, ... }:

{
	time.timeZone = "America/Chicago";
	systemd.extraConfig = "DefaultLimitNOFILE=1048576";
	sound.enable = true;
	environment.pathsToLink = [ "/share/zsh" ];

	security.pam.loginLimits = [{
		domain = "*";
		type = "hard";
		item = "nofile";
		value = "1048576";
	}];

	virtualisation.libvirtd = {
		enable = true;
		onBoot = "ignore";
		onShutdown = "shutdown";

		qemuVerbatimConfig = ''
			namespaces = []
			user = "okina"
			group = "kvm"
			max_files = 2048
			nographics_allow_host_audio = 1;

			cgroup_device_acl = [
				"/dev/kvm",
				"/dev/input/by-id/usb-Logitech_Gaming_Keyboard_G610_017D356A3834-event-kbd",
				"/dev/input/by-id/usb-Logitech_Gaming_Mouse_G502_136D37653136-event-mouse",
				"/dev/null", "/dev/full", "/dev/zero",
				"/dev/random", "/dev/urandom",
				"/dev/ptmx", "/dev/kvm", "/dev/kqemu",
				"/dev/rtc","/dev/hpet", "/dev/sev"
			]
		'';
	};

	hardware = {
		cpu.amd.updateMicrocode = true;

		opengl = {
			driSupport32Bit = true;
			extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
		};

		pulseaudio = {
			enable = true;
			support32Bit = true;
			extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";

			daemon.config = {
				default-sample-format = "s24le";
				default-sample-rate = "192000";
				resample-method = "speex-float-7";
			};
		};
	};

	fonts = {
		fontconfig.cache32Bit = true;
		fonts = with pkgs; [ ipafont baekmuk-ttf ];
	};
}

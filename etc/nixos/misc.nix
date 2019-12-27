{ pkgs, ... }:

{
	time.timeZone = "America/Chicago";
	location.provider = "geoclue2";
	systemd.extraConfig = "DefaultLimitNOFILE=1048576";
	sound.enable = true;

	security.pam.loginLimits = [{
		domain = "*";
		type = "hard";
		item = "nofile";
		value = "1048576";
	}];

	virtualisation = {
		docker.enable = true;

		libvirtd = {
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
					"/dev/input/by-path/pci-0000:2a:00.1-usb-0:5:1.0-event-kbd",
					"/dev/input/by-path/pci-0000:2a:00.3-usb-0:2:1.0-event-mouse",
					"/dev/null", "/dev/full", "/dev/zero",
					"/dev/random", "/dev/urandom",
					"/dev/ptmx", "/dev/kvm", "/dev/kqemu",
					"/dev/rtc","/dev/hpet", "/dev/sev"
				]
			'';
		};
	};

	hardware = {
		cpu.amd.updateMicrocode = true;

		opengl = {
			driSupport32Bit = true;
			s3tcSupport = true;
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
		fonts = [ pkgs.ipafont ];
	};
}

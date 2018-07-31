{
	# Program configuration.
	programs = {
		# Enable the GPG agent.
		gnupg.agent.enable = true;

		# Enable Java.
		java.enable = true;

		# Zsh configuration.
		zsh = {
			enable = true;
			enableCompletion = true;
			autosuggestions.enable = true;
			syntaxHighlighting.enable = true;
			promptInit = "autoload -U promptinit && promptinit && prompt adam1";

			shellAliases = {
				# Enable ls to color output.
				ls = "ls --color=auto";
				# List attributes.
				ll = "ls -l";
				# List hidden files too.
				l = "ll -a";

				# Rebuild the system.
				nrebuild = "sudo nixos-rebuild switch";

				# Upgrade the system.
				nupgrade = "sudo nix-channel --update && sudo nixos-rebuild switch";

				# Upgrade the system. (boot)
				nboot = "sudo nix-channel --update && sudo nixos-rebuild boot";

				# Collect garbage.
				ncollect = "sudo nix-collect-garbage -d";

				# Japanese locale.
				jp8 = "LC_ALL=ja_JP.UTF-8";

				# 32-bit WINE.
				wine32 = "WINEARCH=win32 WINEPREFIX=~/.wine32";

				# Fix sound.
				fixsound = "pacmd load-module module-alsa-sink device=hw:$(aplay -l | grep \"SteelSeries Arctis 7\" | grep \"USB Audio \#1\" | cut -c 6),1";

				# Spawn Arch Linux instance.
				spawn_arch = "sudo systemd-nspawn -b -M archlinux -D /mnt/containers/archlinux";

				# meguca dev environment.
				meguca_dev = "export GOPATH=~/go:$GOPATH && nix-shell -p jq go nodejs emscripten gcc gnumake cmake pkgconfig go-bindata easyjson quicktemplate ffmpeg-full graphicsmagick ghostscript";

				# Override Mesa OpenGL version to 3.0.
				mesa_override= "MESA_GL_VERSION_OVERRIDE=3.0";
			};
		};

		# Nano configuration.
		nano = {
			syntaxHighlight = true;

			nanorc = ''
				set nowrap
				set tabsize 4
			'';
		};
	};
}

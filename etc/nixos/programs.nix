{
	programs = {
		dconf.enable = true;
		java.enable = true;
		gnupg.agent.enable = true;

		zsh = {
			enable = true;
			enableCompletion = true;
			autosuggestions.enable = true;
			syntaxHighlighting.enable = true;
			promptInit = "autoload -U promptinit && promptinit && prompt adam1";

			shellAliases = {
				# Let ls color output.
				ls = "ls --color=auto";

				# List attributes.
				ll = "ls -l --color=auto";

				# List hidden files too.
				l = "ll -a --color=auto";

				# Rebuild the system.
				nrebuild = "sudo nixos-rebuild switch";

				# Upgrade the system.
				nupgrade = "sudo nixos-rebuild switch --upgrade";

				# Upgrade the system. (boot)
				nboot = "sudo nixos-rebuild boot --upgrade";

				# Collect garbage.
				ncollect = "sudo nix-collect-garbage -d";

				# Japanese locale.
				jp8 = "LC_ALL=ja_JP.UTF-8";

				# 32-bit WINE.
				wine32 = "WINEARCH=win32 WINEPREFIX=~/.wine32";

				# Meguca development environment.
				meguca_dev = "GOPATH=~/go PATH=$PATH:$GOPATH/bin nix-shell -p go nodejs emscripten gcc gnumake cmake pkgconfig go-bindata easyjson quicktemplate ffmpeg-full graphicsmagick ghostscript opencv statik";

				# dumb shit
				cheat_dev = "nix-shell -p gdb cmake SDL2 lua5_3 xdotool gnumake patchelf v8 zlib killall";

				# Override Mesa OpenGL version to 3.0.
				mesa_override = "MESA_GL_VERSION_OVERRIDE=3.0";

				# Looking glass.
				lokg = "looking-glass-client -sSM -K 60 -w 1920 -b 1200";
				lokgf = "looking-glass-client -nsSFM -K 60 -w 1920 -b 1200";
			};
		};

		nano = {
			syntaxHighlight = true;

			nanorc = ''
				set nowrap
				set tabsize 4
			'';
		};
	};
}

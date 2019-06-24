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

				# Meguca development environment.
				meguca_dev = "GOPATH=~/go PATH=$PATH:$GOPATH/bin nix-shell -p go nodejs emscripten gcc gnumake cmake pkgconfig go-bindata easyjson quicktemplate ffmpeg-full graphicsmagick ghostscript opencv statik geoip";

				# Override Mesa OpenGL version to 3.0.
				mesa_override = "MESA_GL_VERSION_OVERRIDE=3.0";
			};
		};

		nano = {
			syntaxHighlight = true;

			nanorc = ''
				set nowrap
				set tabsize 2
			'';
		};
	};
}

{ pkgs, ... }:

{
	programs = {
		dconf.enable = true;
		gnupg.agent.enable = true;

		java = {
			enable = true;
			package = pkgs.jdk12;
		};

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
				nupgrade = "nix-channel --update && sudo nixos-rebuild switch --upgrade";

				# Upgrade the system. (boot)
				nboot = "nix-channel --update && sudo nixos-rebuild boot --upgrade";

				# Collect garbage.
				ncollect = "sudo nix-collect-garbage -d";

				# Japanese locale.
				jp8 = "LC_ALL=ja_JP.UTF-8";

				# Override Mesa OpenGL version to 3.0.
				mesa_override = "MESA_GL_VERSION_OVERRIDE=3.0";

				# Limit network speed to 128KiB d/u.
				nlimit = "sudo sh /etc/scripts/wondershaper -a enp42s0 -d 10 -u 10";

				# Clear network speed limit.
				nclear = "sudo sh /etc/scripts/wondershaper -c -a enp42s0";

				# SSH connect on port 38722
				meguca_ssh = "ssh -p 38722";
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

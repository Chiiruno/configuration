{ pkgs, ... }:

{
	programs = {
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
				nupgrade = "nix-channel --update && sudo nixos-rebuild switch --upgrade";

				# Upgrade the system. (boot)
				nboot = "nix-channel --update && sudo nixos-rebuild boot --upgrade";

				# Collect garbage.
				ncollect = "sudo nix-collect-garbage -d";

				# Generate ffmpeg concat list from ugoira animation.json
				gen_ugo = ''egrep -o '[0-9]+\.[A-Za-z]+|[0-9]+' frames/animation.json | sed -e "0~2n;s/^/file 'frames\//;s/$/'/" -e '1~2n;s/^/duration /' > list.txt'';
				gen_ugo_conv = ''egrep -o '[0-9]+\.[A-Za-z]+|[0-9]+' frames/animation.json | awk 'NR % 2 {print} !(NR % 2) {print $0/1000}' | sed -e "0~2n;s/^/file 'frames\//;s/$/'/" -e '1~2n;s/^/duration /' > list.txt'';
			};
		};

		nano = {
			syntaxHighlight = true;

			nanorc = ''
				set nowrap
				set tabsize 2
			'';
		};

		java = {
			enable = true;
			package = pkgs.jdk12;
		};
	};
}

let
	unstable = import <nixos-unstable> { config = baseConfig; };

	baseConfig = {
		allowUnfree = true;
		pulseaudio = true;
		firefox.enablePlasmaBrowserIntegration = true;
	};
in
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
				nupgrade = "nix-channel --update && sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";

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
	};

	home-manager = {
		useUserPackages = true;
		useGlobalPkgs = true;

		users.okina = { pkgs, ... }: {
			programs = {
				gpg.enable = true;
				ncmpcpp.enable = true;

				keychain = {
					enable = true;
					enableZshIntegration = true;
				};

				ssh = {
					enable = true;
					compression = false;
					controlMaster = "auto";
					controlPath = "~/.ssh/sockets/socket-%r@%h:%p";
					controlPersist = "yes";
					extraConfig = "Ciphers aes128-gcm@openssh.com,aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr";

					matchBlocks = {
						"shamik.ooo" = {
							addressFamily = "inet6";
							hostname = "shamik.ooo";
							identityFile = "~/.ssh/id_ed25519";
							user = "okina";
							port = 13372;
						};
					};
				};

				git = {
					enable = true;
					userName = "Okina Matara";
					userEmail = "okinan@protonmail.com";

					signing = {
						key = "9251272F845312C1";
						signByDefault = true;
					};
				};

				go = {
					enable = true;
					package = unstable.go;
					goPath = ".go";
				};

				htop = {
					enable = true;
					enableMouse = true;
					cpuCountFromZero = true;
					highlightMegabytes = true;
				};

				firefox  = {
					enable = true;
					package = unstable.firefox;

					profiles = {
						"okina" = {
							id = 1337;
							isDefault = true;
							name = "Okina Matara";

							settings = {
								"app.shield.optoutstudies.enabled" = false;
								"browser.download.useDownloadDir" = false;
								"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
								"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
								"browser.newtabpage.activity-stream.feeds.section.highlights" = false;
								"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
								"browser.newtabpage.activity-stream.feeds.snippets" = false;
								"browser.newtabpage.activity-stream.feeds.topsites" = false;
								"browser.newtabpage.enabled" = false;
								"browser.sessionstore.warnOnQuit" = true;
								"browser.startup.homepage" = "about:blank";
								"browser.startup.page" = 3;
								"datareporting.policy.dataSubmissionEnabled" = false;
								"dom.security.https_only_mode" = true;
								"dom.security.https_only_mode_ever_enabled" = true;
								"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
								"extensions.pocket.enabled" = false;
								"media.eme.enabled" = true;
								"network.http.http3.enabled" = true;
								"network.security.esni.enabled" = true;
								"network.trr.mode" = 2;
								"privacy.donottrackheader.enabled" = true;
								"toolkit.telemetry.enabled" = false;
								"toolkit.telemetry.server_owner" = "None";
								"toolkit.telemetry.unified" = false;
							};
						};
					};

#					extensions = {};
				};

				mpv = {
					enable = true;

					config = {
						profile = "opengl-hq";
						scale = "ewa_lanczossharp";
						cscale = "ewa_lanczossharp";
						video-sync = "display-resample";
						interpolation = true;
						tscale = "oversample";
						no-border = true;
						alang = "jp,jpn";
						slang = "en,eng";
						screenshot-format = "png";
						screenshot-png-compression = 9;
						screenshot-template = "%F (%p)";
						screenshot-directory = "/mnt/hdd0/home/okina/Pictures/Screenshots";
						ytdl-format = "bestvideo+bestaudio";
					};
				};

				vscode = {
					enable = true;
					package = unstable.vscodium;
				};
			};

			home.packages = with pkgs; [
				# Utilities
				neofetch
				unstable.virt-manager
				unstable.scream-receivers
				unstable.looking-glass-client

				# Development
				gnumake
				gcc

				# Compression
				p7zip
				unzip
				unrar
				unar
				zstd
				brotli

				# Internet
				telnet
				elinks
				unstable.discord

				# Media
				unstable.mixxx
				unstable.ffmpeg-full
				unstable.youtube-dl
				gimp-with-plugins

				# Games
				unstable.steam

				# KDE
				kdeApplications.ark
				kdeApplications.kgpg
				konversation
				ktorrent
				kdeApplications.okular
				kdeApplications.spectacle
				kdeApplications.gwenview
				unstable.peruse
				plasma-browser-integration
			];
		};
	};
}

{ pkgs, ... }:

{
	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = with pkgs; with kdeApplications; [
		# Utilities
		lm_sensors
		neofetch
		virt-manager
		youtube-dl
		gimp-with-plugins
		scream-receivers
		looking-glass-client

		# Development
		git
		gnumake
		gcc
		go
		pkgconfig
		vscode-with-extensions

		# Compression
		p7zip
		unzip
		unrar
		unar
		zstd
		brotli

		# Internet
		telnet
		firefox
		elinks
		discord

		# Media
		ncmpcpp
		mpv
		mixxx
		ffmpeg-full
		graphicsmagick

		# Games
		steam
		multimc

		# KDE
		ark
		kgpg
		konversation
		ktorrent
		okular
		spectacle
		gwenview
		peruse
		plasma-browser-integration
	];
}

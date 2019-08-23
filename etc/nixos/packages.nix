{ pkgs, ... }:

{
	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = with pkgs; [
		# Utilities.
		lm_sensors
		gnupg
		neofetch
		scrot
		tewisay
		catfish
		ebtables
		dnsmasq
		bridge-utils
		netcat-openbsd
		virtmanager
		barrier
		openssl
		docker-compose
		qt5.qttools

		# Development
		git
		gcc
		go
		rustc
		vscode-with-extensions

		# Compression.
		p7zip
		unzip
		unrar
		unar
		zstd

		# Internet
		firefox
		shadowfox
		midori
		elinks
		qbittorrent
		brave

		# Media.
		mpd
		ncmpcpp
		mpv
		youtube-dl
		gimp
		mcomix
		timidity
		soundfont-fluid

		# Games.
		steam
		multimc

		# Emulation.
		dolphinEmu
		snes9x-gtk
		mgba
		wine

		# KDE.
		ark
		ffmpegthumbs
		kate
		kcalc
		kgpg
		kmail
		konversation
		krename
		okular
		spectacle
		gwenview
	];
}

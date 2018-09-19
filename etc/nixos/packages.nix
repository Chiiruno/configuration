{ pkgs, ... }:

{
	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = with pkgs; [
		# Utilities.
		lm_sensors
		alsaUtils
		gnupg
		winetricks
		neofetch
		scrot
		tewisay
		openssl
		catfish
		qt5.qttools
		ebtables
		dnsmasq
		bridge-utils
		netcat-openbsd
		virtmanager
		barrier

		# Development
		git
		gcc
		go
		nodejs
		rustup
		vscode-with-extensions

		# Compression.
		p7zip
		unzip
		unrar
		unar

		# Internet
		chromium
		midori
		elinks
		qbittorrent

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
		steam-run
		multimc

		# Emulation.
		dolphinEmuMaster
		snes9x-gtk
		mgba
		mupen64plus
		desmume
		citra
		wine

		# KDE.
		ark
		falkon
		ffmpegthumbs
		kate
		kcalc
		kgpg
		kmail
		konversation
		krename
		latte-dock
		okular
		spectacle
		gwenview
	];
}

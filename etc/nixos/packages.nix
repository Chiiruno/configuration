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

		# Development
		gcc
		go
		nodejs
		vscode-with-extensions
		git

		# Compression.
		p7zip
		unzip
		unrar
		unar

		# Internet
		firefox
		chromium
		midori
		palemoon
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
		steam-run-native
		openmw
		minecraft
		multimc
		armagetronad

		# Emulation.
		(lowPrio dolphinEmu)
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
		redshift-plasma-applet
	];
}

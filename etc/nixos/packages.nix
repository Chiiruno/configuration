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

		# Development
		gcc
		go
		nodejs
		vscode-with-extensions

		# Compression.
		p7zip
		unzip
		unrar
		unar

		# Internet
		firefox
		chromium
		qbittorrent
		git

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

		(wine.override {
			wineRelease = "unstable";
			wineBuild = "wineWow";
#			gstreamerSupport = false;
		})

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
		okular
		spectacle
		gwenview
		redshift-plasma-applet
	];
}

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

		# Compression.
		p7zip
		unzip
		unrar
		unar

		# Internet
		deluge
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

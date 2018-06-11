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
		steam-run-native

		# Compression.
		p7zip
		unzip
		unrar
		unar

		# Internet
		firefox
		chromium
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
#		obs-studio

		# Games.
		steam
		openmw
		minecraft
		multimc
		armagetronad

		# Emulation.
		dolphinEmu
		dolphinEmuMaster
		retroarch

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
	];
}

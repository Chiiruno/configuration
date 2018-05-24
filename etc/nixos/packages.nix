{ pkgs, ... }:

{
	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = with pkgs; [
		# Meguca.
		cmake
		pkgconfig
		go
		gcc
		gnumake
		nodejs
		(import <nixos-unstable> {}).emscripten
		ghostscript
		ffmpeg-full
		graphicsmagick

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
		firefox
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
		armagetronad

		# Emulation.
		dolphinEmu

		(wine.override {
			wineRelease = "unstable";
			wineBuild ="wineWow";
			pngSupport = true;
			jpegSupport = true;
			tiffSupport = true;
			gettextSupport = true;
			fontconfigSupport = true;
			alsaSupport = true;
			gtkSupport = true;
			openglSupport = true;
			tlsSupport = true;
			gstreamerSupport = true;
			cupsSupport = true;
			colorManagementSupport = true;
			dbusSupport = true;
			mpg123Support = true;
			openalSupport = true;
			openclSupport = true;
			cairoSupport = true;
			odbcSupport = true;
			netapiSupport = true;
			cursesSupport = true;
			vaSupport = true;
			pcapSupport = true;
			v4lSupport = true;
			saneSupport = true;
			gsmSupport = true;
			gphoto2Support = true;
			ldapSupport = true;
			pulseaudioSupport = true;
			udevSupport = true;
			xineramaSupport = true;
			xmlSupport = true;
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

{ pkgs, ... }:

{
	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = with pkgs; with kdeApplications; [
		# Utilities
		lm_sensors
		neofetch
		virtmanager
		openssl
		docker-compose
		youtube-dl
		ffmpeg-full
		gimp-with-plugins
		shadowfox
		pkgconfig
		scream-receivers
		dnsmasq
		win-qemu

		# Plan 9
		plan9port

		# Development
		git
		mercurial
		gnumake
		cmake
		gcc
		clang
		go
		rustup
		nodejs
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
		qbittorrent
		keybase-gui
		firefox
		chromium
		elinks
		mumble

		# Media
		ncmpcpp
		mpv
		mcomix
		mixxx

		# Games
		steam
		multimc

		# KDE
		akonadi
		ark
		kate
		kcalc
		kgpg
		kmail
		kmail-account-wizard
		konversation
		krename
		okular
		spectacle
		gwenview
		pinentry_qt5
	];
}

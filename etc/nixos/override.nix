let
	baseConfig = { allowUnfree = true; };
	unstable = import <nixos-unstable> { config = baseConfig; };
in {
	imports = [
		<nixos-unstable/nixos/modules/services/databases/postgresql.nix>
		<nixos-unstable/nixos/modules/services/web-servers/hydron.nix>
		<nixos-unstable/nixos/modules/services/networking/zeronet.nix>
	];

	disabledModules = [
		"services/databases/postgresql.nix"
		"services/web-servers/hydron.nix"
		"services/networking/zeronet.nix"
	];

	nixpkgs.config = baseConfig // {
		packageOverrides = pkgs: {
			postgresql = unstable.postgresql;
			hydron = unstable.hydron;
			zeronet = unstable.zeronet;
			multimc = unstable.multimc;
		};
	};
}

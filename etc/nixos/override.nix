let
	baseConfig = { allowUnfree = true; };
	unstable = import <nixos-unstable> { config = baseConfig; };
in {
	imports = [ <nixos-unstable/nixos/modules/services/networking/zeronet.nix> ];
	disabledModules = [ "services/networking/zeronet.nix" ];

	nixpkgs.config = baseConfig // {
		packageOverrides = pkgs: {
			zeronet = unstable.zeronet;
		};
	};
}

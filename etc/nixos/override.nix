let
	baseConfig = { allowUnfree = true; };
	unstable = import <nixos-unstable> { config = baseConfig; };
in {
	nixpkgs.config = baseConfig // {
		packageOverrides = pkgs: {
			multimc = unstable.multimc;
		};
	};
}

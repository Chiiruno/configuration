let
	baseConfig = { allowUnfree = true; };
	unstable = import <nixos-unstable> { config = baseConfig; };
in {
	nixpkgs.config = baseConfig // {
		packageOverrides = pkgs: {
			go = unstable.go;
			gcc = unstable.gcc;
			clang = unstable.clang;
			vscode-with-extensions = unstable.vscode-with-extensions;
			mixxx = unstable.mixxx;
		};
	};
}

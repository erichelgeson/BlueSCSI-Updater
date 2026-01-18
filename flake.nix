{
  description = "BlueSCSI firmware updater";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            dfu-util
            openocd
            gnugrep
            coreutils
          ];

          shellHook = ''
            echo "BlueSCSI Updater environment loaded"
            echo "Run ./flash-nixos.sh to start the updater"
          '';
        };
      }
    );
}

let

  src = import ./nix/sources.nix;

  overlay = self: super: {
  };

  pkgs = import src.nixpkgs { overlays = [overlay]; };

  agda = pkgs.agda.withPackages (ps: with ps; [
    standard-library
  ]);

in {

  env = pkgs.buildEnv {
    name = "learn-agda";
    paths = [ agda ];
  };

}

{ self, ... }:
{
  perSystem =
    {
      lib,
      pkgs,
      self',
      inputs',
      ...
    }:
    let
      build =
        pkgs.runCommand "website" { buildInputs = [ ]; } ''
          mkdir -p $out
          ls -lar ${self}
          cp -r ${self}/website/* $out
        '';
    in
    {
      packages.default = build;
      packages.serve = pkgs.writeShellScriptBin "serve-local" ''
        ${pkgs.python3}/bin/python -m http.server 1111 \
          -d website
      '';
    };
}

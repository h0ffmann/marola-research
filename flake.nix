{
  description = "marola-research: the papers are rendered with h0ffmann/picasso's paper lab";

  # `nix flake update` picks up a new revision of the lab.
  inputs.paper.url = "github:h0ffmann/picasso?dir=labs/paper";

  outputs = { paper, ... }: {
    # default: the lab's own shell (pandoc, citeproc, XeLaTeX, just, poppler, librsvg).
    # md: the three analysers of `just md-quality`, from the lab's nixpkgs, so flake.lock pins
    # them with everything else.
    devShells = builtins.mapAttrs
      (system: shells:
        let pkgs = paper.inputs.nixpkgs.legacyPackages.${system}; in
        shells // {
          md = pkgs.mkShell { packages = [ pkgs.markdownlint-cli2 pkgs.vale pkgs.lychee pkgs.git ]; };
        })
      paper.devShells;
  };
}

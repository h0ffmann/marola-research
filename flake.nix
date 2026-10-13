{
  description = "marola-research: the papers are rendered with h0ffmann/picasso's paper lab";

  # `nix flake update` picks up a new revision of the lab.
  inputs.paper.url = "github:h0ffmann/picasso?dir=labs/paper";

  # The shell is the lab's own: pandoc, citeproc, XeLaTeX and just, pinned by flake.lock.
  outputs = { paper, ... }: { devShells = paper.devShells; };
}

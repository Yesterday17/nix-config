# https://github.com/google-gemini/gemini-cli
# https://github.com/NixOS/nixpkgs/pull/419945
{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  nix-update-script,
}:

let
  pname = "gemini-cli";
  version = "0.1.5";
in
buildNpmPackage rec {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "google-gemini";
    repo = "gemini-cli";

    rev = "01ff27709d7b62491bc2438fb8939da034c1c003";
    hash = "sha256-JgiK+8CtMrH5i4ohe+ipyYKogQCmUv5HTZgoKRNdnak=";
  };

  npmDepsHash = "sha256-yoUAOo8OwUWG0gyI5AdwfRFzSZvSCd3HYzzpJRvdbiM=";

  fixupPhase = ''
    runHook preFixup

    # Remove broken symlinks
    find $out -type l -exec test ! -e {} \; -delete 2>/dev/null || true

    mkdir -p "$out/bin"
    ln -sf "$out/lib/node_modules/@google/gemini-cli/bundle/gemini.js" "$out/bin/gemini"

    patchShebangs "$out/bin" "$out/lib/node_modules/@google/gemini-cli/bundle/"

    runHook postFixup
  '';

  passthru.updateScript = nix-update-script { };
}

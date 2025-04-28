# https://github.com/fireattack/gfile
{
  lib,
  fetchPypi,
  pkgs,
}:
pkgs.python3Packages.buildPythonPackage rec {
  pname = "gigafile";
  version = "3.2.3";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-pYa7+UJKbeEozwMxKrOfgzyJYE55Ugovt5w4DDfa1k8=";
  };
  propagatedBuildInputs = with pkgs.python3Packages; [
    requests
    requests-toolbelt
    tqdm
    beautifulsoup4
  ];
}

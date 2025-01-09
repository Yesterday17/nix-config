# https://github.com/NixOS/nixpkgs/pull/344796
{
  fetchurl,
  appimageTools,
  lib,
}:
let
  pname = "navicat-premium-lite";
  version = "17.1.6";
  src = fetchurl {
    url = "https://download.navicat.com/download/navicat17-premium-lite-cs-x86_64.AppImage";
    hash = "sha256-NQb+5tuSUdCnPo4gDQpN9QZUxP5utU/jv8eJjrwmwnQ=";
  };
  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    cp -r ${appimageContents}/usr/share $out/share
    substituteInPlace $out/share/applications/navicat.desktop \
      --replace-fail "Exec=navicat" "Exec=navicat-premium-lite"
  '';

  meta = {
    homepage = "https://www.navicat.com/products/navicat-premium-lite";
    description = "Database development tool that allows you to simultaneously connect to many databases";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ aucub ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "navicat-premium-lite";
  };
}

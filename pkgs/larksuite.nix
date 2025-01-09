{
  addDriverRunpath,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  autoPatchelfHook,
  cairo,
  cups,
  curl,
  dbus,
  dpkg,
  expat,
  fetchurl,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  glibc,
  gnutls,
  gtk3,
  lib,
  libGL,
  libX11,
  libXScrnSaver,
  libXcomposite,
  libXcursor,
  libXdamage,
  libXext,
  libXfixes,
  libXi,
  libXrandr,
  libXrender,
  libXtst,
  libappindicator-gtk3,
  libcxx,
  libdbusmenu,
  libdrm,
  libgcrypt,
  libglvnd,
  libnotify,
  libpulseaudio,
  libuuid,
  libxcb,
  libxkbcommon,
  libxkbfile,
  libxshmfence,
  makeShellWrapper,
  libgbm,
  nspr,
  nss,
  pango,
  pciutils,
  pipewire,
  pixman,
  stdenv,
  systemd,
  wayland,
  xdg-utils,
  writeScript,

  # for custom command line arguments, e.g. "--use-gl=desktop"
  commandLineArgs ? "",
}:

let
  sources = {
    x86_64-linux = fetchurl {
      url = "https://sf16-va.larksuitecdn.com/obj/lark-artifact-storage/afc02e52/Lark-linux_x64-7.32.11.deb";
      sha256 = "sha256-hfLKbKzZzOYqNGEoLw4gMXI2jfNvtFPU7hAODeA9SxU=";
    };
    aarch64-linux = fetchurl {
      url = "https://sf16-va.larksuitecdn.com/obj/lark-artifact-storage/240d90bd/Lark-linux_arm64-7.32.11.deb";
      sha256 = "sha256-IsjGuyHvmDNjJYCBXR1NFShaVsWUYcF3OV5ihY9fJl0=";
    };
  };

  supportedPlatforms = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  rpath = lib.makeLibraryPath [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    glibc
    gnutls
    libGL
    libX11
    libXScrnSaver
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXtst
    libappindicator-gtk3
    libcxx
    libdbusmenu
    libdrm
    libgcrypt
    libglvnd
    libnotify
    libpulseaudio
    libuuid
    libxcb
    libxkbcommon
    libxkbfile
    libxshmfence
    libgbm
    nspr
    nss
    pango
    pciutils
    pipewire
    pixman
    stdenv.cc.cc
    systemd
    wayland
    xdg-utils
  ];
in
stdenv.mkDerivation {
  version = "7.32.11";
  pname = "larksuite";

  src =
    sources.${stdenv.hostPlatform.system}
      or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  nativeBuildInputs = [
    autoPatchelfHook
    makeShellWrapper
    dpkg
  ];

  buildInputs = [
    gtk3

    # for autopatchelf
    alsa-lib
    cups
    curl
    libXdamage
    libXtst
    libdrm
    libgcrypt
    libpulseaudio
    libxshmfence
    libgbm
    nspr
    nss
  ];

  dontUnpack = true;
  installPhase = ''
    # This deb file contains a setuid binary,
    # so 'dpkg -x' doesn't work here.
    dpkg --fsys-tarfile $src | tar --extract
    mkdir -p $out
    mv usr/share $out/
    mv opt/ $out/

    substituteInPlace $out/share/applications/bytedance-lark.desktop \
      --replace /usr/bin/bytedance-lark-stable $out/opt/bytedance/lark/bytedance-lark

    # Wrap lark and vulcan
    # Lark is the main executable, vulcan is the builtin browser
    for executable in $out/opt/bytedance/lark/{lark,vulcan/vulcan}; do
      # FIXME: Add back NIXOS_OZONE_WL support once upstream fixes the crash on native Wayland (see #318035)
      wrapProgram $executable \
        --prefix XDG_DATA_DIRS    :  "$XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH" \
        --prefix LD_LIBRARY_PATH  :  ${rpath}:$out/opt/bytedance/lark:${addDriverRunpath.driverLink}/share \
        ${lib.optionalString (
          commandLineArgs != ""
        ) "--add-flags ${lib.escapeShellArg commandLineArgs}"}
    done

    mkdir -p $out/share/icons/hicolor
    base="$out/opt/bytedance/lark"
    for size in 16 24 32 48 64 128 256; do
      mkdir -p $out/share/icons/hicolor/''${size}x''${size}/apps
      ln -s $base/product_logo_$size.png $out/share/icons/hicolor/''${size}x''${size}/apps/bytedance-lark.png
    done

    mkdir -p $out/bin
    ln -s $out/opt/bytedance/lark/bytedance-lark $out/bin/bytedance-lark

    # lark comes with a bundled libcurl.so
    # and has many dependencies that are hard to satisfy
    # e.g. openldap version 2.4
    # so replace it with our own libcurl.so
    ln -sf ${curl}/lib/libcurl.so $out/opt/bytedance/lark/libcurl.so
  '';

  passthru = {
    inherit sources;
    updateScript = writeScript "update-lark.sh" ''
      #!/usr/bin/env nix-shell
      #!nix-shell -i bash -p curl jq common-updater-scripts

      for platform in ${lib.escapeShellArgs supportedPlatforms}; do
        if [ $platform = "x86_64-linux" ]; then
          platform_id=Linux_deb_x64
        elif [ $platform = "aarch64-linux" ]; then
          platform_id=Linux_deb_arm
        else
          echo "Unsupported platform: $platform"
          exit 1
        fi
        package_info=$(curl -sf "https://www.larksuite.com/api/downloads")
        update_link=$(echo $package_info | jq -r ".versions.$platform_id.download_link" | sed 's/lf[0-9]*-ug-sign.feishucdn.com/sf3-cn.feishucdn.com\/obj/;s/?.*$//')
        new_version=$(echo $package_info | jq -r ".versions.$platform_id.version_number" | sed -n 's/.*@V//p')
        sha256_hash=$(nix-prefetch-url $update_link)
        sri_hash=$(nix hash to-sri --type sha256 $sha256_hash)
        update-source-version lark $new_version $sri_hash $update_link --system=$platform --ignore-same-version --source-key="sources.$platform"
      done
    '';
  };

  meta = with lib; {
    description = "All-in-one collaboration suite";
    homepage = "https://www.larksuite.com/en/";
    downloadPage = "https://www.larksuite.com/en_us/download";
    license = licenses.unfree;
    platforms = supportedPlatforms;
    maintainers = with maintainers; [ yesterday17 ];
  };
}

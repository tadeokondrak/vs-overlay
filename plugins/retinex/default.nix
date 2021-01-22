{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-retinex";
  version = "r4";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-Retinex";
    rev = version;
    sha256 = "108jmawfn87ydabpxkb0srbk2r8vgpfn0kiby4g56msbc0rpvc6g";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  installPhase =
    let
      ext = stdenv.targetPlatform.extensions.sharedLibrary;
    in ''
      install -D libretinex${ext} $out/lib/vapoursynth/libretinex${ext}
    '';

  meta = with lib; {
    description = "Retinex algorithm for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Retinex";
    license = licenses.gpl3;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

{ lib, stdenv, fetchFromGitHub, vapoursynth }:

let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "vs-continuityfixer";
  version = "6.1";

  src = fetchFromGitHub {
    owner = "MonoS";
    repo = "VS-ContinuityFixer";
    rev = "V6";
    sha256 = "1hkbmfvs4zkr9177qsai012ba4iqj0vb7gw2ngvgcn0px92vclgw";
  };

  buildInputs = [ vapoursynth ];

  buildPhase = ''
    c++ -shared -fPIC -O2 -msse2 -mfpmath=sse -I${vapoursynth}/include/vapoursynth \
        continuity.cpp -o continuity${ext}
  '';

  installPhase = ''
    install -D continuity${ext} $out/lib/vapoursynth/continuity${ext}
  '';

  meta = with lib; {
    description = "Continuity Fixer port for Vapoursynth";
    homepage = "https://github.com/MonoS/VS-ContinuityFixer";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

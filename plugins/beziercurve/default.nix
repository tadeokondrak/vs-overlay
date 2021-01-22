{ stdenv, fetchFromGitHub, vapoursynth }:

let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "vapoursynth-beziercurve";
  version = "r3";

  src = fetchFromGitHub {
    owner = "kewenyu";
    repo = "VapourSynth-BezierCurve";
    rev = version;
    sha256 = "1513ndj7sxwihyxx6x9ciyd8jhw9vs6lhzw7fpl7cz7fdj49wwi6";
  };

  buildInputs = [ vapoursynth ];

  patchPhase = ''
    substituteInPlace VapourSynth-BezierCurve/BezierCurve.h \
        --replace '<vapoursynth\' '<vapoursynth/'
  '';

  buildPhase = ''
    c++ -fPIC -shared -I${vapoursynth}/include/vapoursynth \
        -o VapourSynth-BezierCurve${ext} \
	      VapourSynth-BezierCurve/BezierCurve.cpp \
        VapourSynth-BezierCurve/CubicBezierCurve.cpp \
        VapourSynth-BezierCurve/QuadraticBezierCurve.cpp \
        VapourSynth-BezierCurve/VapourSynth-BezierCurve.cpp
  '';

  installPhase = ''
    install -D VapourSynth-BezierCurve${ext} $out/lib/vapoursynth/VapourSynth-BezierCurve${ext}
  '';

  meta = with stdenv.lib; {
    description = "A bézier curve plugin for VapourSynth";
    homepage = https://github.com/kewenyu/VapourSynth-BezierCurve;
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

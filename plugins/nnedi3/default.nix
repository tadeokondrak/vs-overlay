{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, vapoursynth, yasm }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-nnedi3";
  version = "12";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "1valcf8ns4wrfq6q5js029a93i58vr37mqw5na6922avg04wzpwd";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ];
  buildInputs = [ vapoursynth yasm ];

  meta = with lib; {
    description = "nnedi3 filter for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-nnedi3";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

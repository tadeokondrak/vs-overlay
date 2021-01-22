{ lib, stdenv, fetchFromGitHub, which, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-tnlmeans";
  version = "unstable-2015-02-25";

  src = fetchFromGitHub {
    owner = "VFR-maniac";
    repo = "VapourSynth-TNLMeans";
    rev = "22a40afaf78b6932800f552c43edc510da2d50a3";
    sha256 = "02abjb5dhsvgng7y4ybm96zbls2b4pzjwr6rqkcarx32malqc3jl";
  };

  preConfigure = ''
    patchShebangs .
  '';

  nativeBuildInputs = [ which ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "An implementation of the NL-means denoising algorithm";
    homepage = https://github.com/VFR-maniac/VapourSynth-TNLMeans;
    license = licenses.lgpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

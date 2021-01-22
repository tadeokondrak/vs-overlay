{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth, fftwSinglePrec }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-bm3d";
  version = "r8";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-BM3D";
    rev = version;
    sha256 = "0hifiyqr0vp3rkqrjbz2fvka7s8xvcpl58rjf0rvljs64bxia4v7";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth fftwSinglePrec ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "BM3D denoising filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D";
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

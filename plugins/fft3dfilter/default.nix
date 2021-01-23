{ fetchFromGitHub, fetchpatch, fftwFloat, lib, meson, ninja, pkg-config, stdenv, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-FFT3DFilter";
  version = "unstable-2020-08-05"; # last version before requiring v4 api

  src = fetchFromGitHub {
    owner = "myrsloik";
    repo = pname;
    rev = "64323f0fdee4dd4fe429ee6287906dbae8e7571c";
    sha256 = "0s2wf1i733srsqgz6fhs7kyra55pib9n5xkx9hpqjjv4sxlnfc9l";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ fftwFloat vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "A VapourSynth port of FFT3DFilter";
    homepage = "https://github.com/myrsloik/VapourSynth-FFT3DFilter";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

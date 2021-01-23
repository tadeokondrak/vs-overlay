{ fetchFromGitHub, fftwFloat, lib, meson, ninja, pkg-config, stdenv, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-DCTFilter";
  version = "r2.1";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "032l2dh28jznplh8ww8hzr0fmm6hx34f0k29gqyyjksmn3ympr00";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ fftwFloat vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "Renewed DCTFilter filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DCTFilter";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

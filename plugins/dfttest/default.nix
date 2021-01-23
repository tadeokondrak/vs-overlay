{ fetchFromGitHub, fetchpatch, fftwFloat, lib, meson, ninja, pkg-config, stdenv, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-DFTTest";
  version = "r7";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "1a13lziplfn8czn0rzpdj8pki8hjs2j1450xki3j09lb2ql2fm6q";
  };

  patches = [
    # handle fftw3f_threads dependency
    (fetchpatch {
      url = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DFTTest/commit/89034df3fa630cbc9d73fd3ed9bcc222468f3fee.diff";
      sha256 = "0hm00wqqnb1f1kqbvyxyj37b5050dqzlb2cvp86qqiaai7fwq29y";
    })
  ];

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ fftwFloat vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "A DFTTest filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DFTTest";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

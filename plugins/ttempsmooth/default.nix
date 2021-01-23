{ fetchFromGitHub, lib, meson, ninja, pkg-config, stdenv, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-TTempSmooth";
  version = "r3.1";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "0h7wxqr3kpq92pr2kbzjljlkg57l1a40w662p322l4r7587x4zdz";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "A TTempSmooth filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TTempSmooth";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

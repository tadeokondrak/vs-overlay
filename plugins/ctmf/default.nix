{ fetchFromGitHub, fftwFloat, lib, meson, ninja, pkg-config, stdenv, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-CTMF";
  version = "r5";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "138gbag1m3cg2bizc5ncxgriz3aw7dkqh1fpky3grlkspn5jc9x5";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "A CTMF filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CTMF";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

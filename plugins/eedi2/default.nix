{ stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-eedi2";
  version = "r7.1";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-EEDI2";
    rev = version;
    sha256 = "10yfndb4q5zd450v5di331r3hm1mfikw370jvxydd98b0lbjpp8f";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with stdenv.lib; {
    description = "EEDI2 filter for VapourSynth";
    homepage = https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI2;
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

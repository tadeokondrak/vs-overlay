{ fetchFromGitHub, lib, meson, ninja, pkg-config, stdenv, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-CAS";
  version = "r2";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "0zcqz6vgfqy4lshc0cvf8hijs2y7c4nvm5nzmb8fl8si38d96rf5";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "CAS filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CAS";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

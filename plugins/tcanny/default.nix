{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth, boost, opencl-headers, ocl-icd }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-tcanny";
  version = "r12";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-TCanny";
    rev = version;
    sha256 = "1jsvgxb94klqwh40820zfw8radrnlr3w3lf2kkzjp6r97kgr5i37";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth boost opencl-headers ocl-icd ];

  # https://github.com/NixOS/nixpkgs/issues/86131
  BOOST_INCLUDEDIR = "${lib.getDev boost}/include";
  BOOST_LIBRARYDIR = "${lib.getLib boost}/lib";

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with stdenv.lib; {
    description = "TCanny filter for VapourSynth";
    homepage = https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TCanny;
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

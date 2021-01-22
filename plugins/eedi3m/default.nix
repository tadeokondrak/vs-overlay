{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth, boost, opencl-headers, ocl-icd }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-eedi3";
  version = "r4";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-EEDI3";
    rev = version;
    sha256 = "1q79l27arcfl7k49czsspb4z7zfr616xsxsb04x9b4d9l763716x";
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

  meta = with lib; {
    description = "Renewed EEDI3 filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

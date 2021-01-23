{ boost
, fetchFromGitHub
, lib
, meson
, ninja
, pkg-config
, stdenv
, vapoursynth
, ocl-icd
, opencl-headers
}:

stdenv.mkDerivation rec {
  pname = "VapourSynth-NNEDI3CL";
  version = "r8";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "0j99ihxy295plk1x5flgwzjkcjwyzqdmxnxmda9r632ksq9flvyd";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [
    boost
    ocl-icd
    opencl-headers
    vapoursynth
  ];

  # https://github.com/NixOS/nixpkgs/issues/86131
  BOOST_INCLUDEDIR = "${lib.getDev boost}/include";
  BOOST_LIBRARYDIR = "${lib.getLib boost}/lib";

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "An OpenCL accelerated nnedi3 filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

{ lib, stdenv, fetchFromGitHub, which, pkg-config, vapoursynth, boost, opencl-headers, ocl-icd }:

stdenv.mkDerivation rec {
  pname = "knlmeanscl";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "Khanattila";
    repo = "KNLMeansCL";
    rev = "v${version}";
    sha256 = "035gcd3ppgljinlhh7k1kfr1394isgavwy9h6znshpl9npgi67cd";
  };

  dontAddPrefix = true;
  configureFlags = [ "--install=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ which pkg-config ];
  buildInputs = [ vapoursynth boost opencl-headers ocl-icd ];

  meta = with lib; {
    description = "An optimized OpenCL implementation of the Non-local means de-noising algorithm";
    homepage = "https://github.com/Khanattila/KNLMeansCL";
    license = licenses.gpl3;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

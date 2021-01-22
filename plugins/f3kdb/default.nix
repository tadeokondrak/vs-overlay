{ stdenv, fetchFromGitHub, wafHook, python3, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "flash3kyuu_deband";
  version = "unstable-2018-08-09";

  src = fetchFromGitHub {
    owner = "SAPikachu";
    repo = pname;
    rev = "c57e9d6a535ec9a85fb5415a405f099cbe69f535";
    sha256 = "1jkp6b29adjfwl94r8snvk4fv2vy0rgvswsyda5f4jb3lf9hds59";
  };

  wafConfigureFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  nativeBuildInputs = [ wafHook python3 ];
  buildInputs = [ vapoursynth ];

  meta = with stdenv.lib; {
    description = "A deband library and filter for AviSynth/VapourSynth";
    homepage = https://github.com/SAPikachu/flash3kyuu_deband;
    license = licenses.gpl3;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

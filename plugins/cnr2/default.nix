{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-cnr2";
  version = "1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "1l77vzmaxqkdmmq1sbpmgn05lvaz06q12wg1rbzyasq34kic47ch";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "Temporal chroma denoiser for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-cnr2";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

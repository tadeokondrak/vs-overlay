{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-msmoosh";
  version = "1.1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "1lqz5xml3j2fs6acrihf1sfhf1397kxsra9j6ky00wll8klcnv0d";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "A VapourSynth plugin providing MSharpen and MSmooth";
    homepage = "https://github.com/dubhater/vapoursynth-msmoosh";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

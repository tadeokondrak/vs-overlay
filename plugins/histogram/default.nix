{ autoreconfHook, fetchFromGitHub, lib, pkg-config, stdenv, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-histogram";
  version = "2";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "1wdjf44cl6sw7cqiv92q20gnn5bqlbln6pqxf41db7arjv93dh9l";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "Histogram plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-histogram";
    license = licenses.gpl2Plus; # https://github.com/dubhater/vapoursynth-histogram/issues/2
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

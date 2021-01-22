{ stdenv, fetchFromGitHub, autoreconfHook, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "fmtconv";
  version = "r22";

  src = fetchFromGitHub {
    owner = "EleonoreMizo";
    repo = pname;
    rev = version;
    sha256 = "1nvanskvh8qv45h7islwgnyrvdkcn7h9jks5fskg4c00aj6bxrrn";
  };

  preAutoreconf = "cd build/unix";

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ vapoursynth ];

  meta = with stdenv.lib; {
    description = "Format conversion tools for VapourSynth";
    homepage = https://github.com/EleonoreMizo/fmtconv;
    license = licenses.wtfpl;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

{ stdenv, fetchFromGitHub, pkg-config, which, vapoursynth, ffmpeg, l-smash }:

stdenv.mkDerivation {
  pname = "lsmashsource";
  version = "unstable-2019-09-15"; # last (only) release is from 2013 and there has still been development

  src = fetchFromGitHub {
    owner = "VFR-maniac";
    repo = "L-SMASH-Works";
    rev = "198cc7814c93209e23f1c6a20daffd651945ba2b";
    sha256 = "1pb8rrh184pxy5calwfnmm02i0by8vc91c07w4ygj50y8yfqa3br";
  };

  preConfigure = ''
    patchShebangs .
    cd VapourSynth
  '';

  nativeBuildInputs = [ pkg-config which ];
  buildInputs = [ vapoursynth ffmpeg l-smash ];
}

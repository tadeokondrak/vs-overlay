{ lib, stdenv, fetchFromGitHub, pkg-config, vapoursynth }:

let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "vapoursynth-wwxd";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "01197hxrmm9az7mbm8jrjslm8pg9pzzvrcz9c5ki8dajgmmz9hym";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ vapoursynth ];

  buildPhase = ''
    gcc -o libwwxd${ext} -fPIC -shared -O2 -Wall -Wextra -Wno-unused-parameter \
        $(pkg-config --cflags vapoursynth) \
        src/wwxd.c src/detection.c
  '';

  installPhase = ''
    install -D libwwxd${ext} $out/lib/vapoursynth/libwwxd${ext}
  '';

  meta = with lib; {
    description = "Xvid-like scene change detection for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-wwxd";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

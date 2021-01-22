{ fetchFromGitHub, lib, meson, ninja, pkg-config, python3, stdenv, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-descale";
  version = "r6";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = version;
    sha256 = "093dk125y4gacvhrh10x1i5g2qbsjl4spz74gjjm7xbvrvi1sc72";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vs.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  postInstall = ''
    install -D ../descale.py $out/${python3.sitePackages}/descale.py
  '';

  meta = with lib; {
    description = "VapourSynth plugin to undo upscaling";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

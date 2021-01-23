{ buildPythonApplication
, fetchFromGitHub
, ffms
, imagemagick
, lib
, matplotlib
, vapoursynth
, vapoursynthPlugins
}:
let
  vapoursynth-with-plugins = vapoursynth.withPlugins (with vapoursynthPlugins; [
    ffms2
    descale
  ]);
in
buildPythonApplication rec {
  pname = "getnative";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "Infiziert90";
    repo = pname;
    rev = version;
    sha256 = "17hz0dd5f13zv8v8mvc0fzslkki5z9c9a908gpmqb01qvmaw362p";
  };

  # vapoursynth is not recognised during installation
  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=45" ""
  '';

  propagatedBuildInputs = [
    matplotlib
    vapoursynth-with-plugins
  ];

  checkInputs = [ imagemagick ];
  checkPhase = ''
    convert -size 1280x720 canvas: +noise Random test.png
    $out/bin/getnative --min-height 699 --max-height 700 test.png
    $out/bin/getnative --min-height 699 --max-height 700 -u ffms2.Source test.png
  '';

  meta = with lib; {
    description = "A cli tool to find the native resolution(s) of upscaled material (mostly anime)";
    homepage = "https://github.com/Infiziert90/getnative";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

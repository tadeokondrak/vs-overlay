{ buildPythonPackage
, fetchFromGitHub
, lib
, python3
, vapoursynth
, vapoursynthPlugins
}:
buildPythonPackage rec {
  pname = "vsTAAmbk";
  version = "unstable-2020-08-13";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "4dddf1a86effb4c6ceae7ca493f1ceed434e37ea";
    sha256 = "06n744b9qr495afrpp4c1i3vcr5cab114rx69xslbhiwy2mg237s";
  };

  patches = [
    ./skip-opencl-test.diff
  ];

  propagatedBuildInputs = with vapoursynthPlugins; [
    awarpsharp2
    cas
    eedi2
    eedi3m
    fmtconv
    havsfunc
    msmoosh
    mvsfunc
    mvtools
    nnedi3
    nnedi3cl
    sangnom
    tcanny
    znedi3
  ];

  format = "other";

  installPhase = ''
    install -D vsTAAmbk.py $out/${python3.sitePackages}/vsTAAmbk.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
    python3 test/vsTAAmbkTestCase.py
  '';

  meta = with lib; {
    description = "An Anti-aliasing script for VapourSynth ported from Avisynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/vsTAAmbk";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

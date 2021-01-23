{ buildPythonPackage
, fetchFromGitHub
, lib
, python3
, vapoursynth
, vapoursynthPlugins
}:

buildPythonPackage rec {
  pname = "havsfunc";
  version = "r33";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "14132gcy0zw348c40y2i8c7n3i1ygcnv9xrf83jp6m3b9v557z7p";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    addgrain
    adjust
    bm3d
    cas
    ctmf
    dctfilter
    deblock
    dfttest
    eedi2
    eedi3m
    fft3dfilter
    fluxsmooth
    fmtconv
    fmtconv
    hqdn3d
    knlmeanscl
    mvsfunc
    mvtools
    nnedi3
    nnedi3cl
    sangnom
    ttempsmooth
    znedi3
  ];

  format = "other";

  installPhase = ''
    install -D havsfunc.py $out/${python3.sitePackages}/havsfunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "havsfunc" ];

  meta = with lib; {
    description = "Holy’s ported AviSynth functions for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/havsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

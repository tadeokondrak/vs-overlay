{ buildPythonPackage
, fetchFromGitHub
, lib
, python3
, vapoursynth
, vapoursynthPlugins
}:

buildPythonPackage rec {
  pname = "mvsfunc";
  version = "r8";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "0y5whczp3skbfbv9ajizddpg2k8hxiiy339gkqhiqby7zlbnvdw2";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    bm3d
    fmtconv
  ];

  format = "other";

  installPhase = ''
    install -D mvsfunc.py $out/${python3.sitePackages}/mvsfunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "mvsfunc" ];

  meta = with lib; {
    description = "mawen1250’s VapourSynth functions";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/mvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

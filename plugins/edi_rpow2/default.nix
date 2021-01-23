{ buildPythonPackage
, fetchgit
, lib
, python3
, vapoursynth
, vapoursynthPlugins
}:

buildPythonPackage rec {
  pname = "edi_rpow2";
  version = "unstable-2018-05-21";

  src = fetchgit {
    url = "https://gist.github.com/YamashitaRen/020c497524e794779d9c";
    rev = "2a20385e50804f8b24f2a2479e2c0f3c335d4853";
    sha256 = "0vaj4v74khrsmyvkpimfkbbyk4bwn065j57fcvzx37fki8a8sw6i";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    eedi2
    eedi3m
    fmtconv
    nnedi3
    nnedi3cl
    znedi3
  ];

  format = "other";

  installPhase = ''
    install -D edi_rpow2.py $out/${python3.sitePackages}/edi_rpow2.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "edi_rpow2" ];

  meta = with lib; {
    description = "A vapoursynth plugin for enlarging images by powers of 2";
    homepage = "https://gist.github.com/YamashitaRen/020c497524e794779d9c";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

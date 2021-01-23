{ buildPythonPackage
, fetchFromGitHub
, lib
, python3
, vapoursynth
}:

buildPythonPackage rec {
  pname = "vapoursynth-adjust";
  version = "1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "0wd6sh788ljb4vj6fd5zv2cx7nl6x1k3lnz44n7p3ac5vfskjz8a";
  };

  format = "other";

  installPhase = ''
    install -D adjust.py $out/${python3.sitePackages}/adjust.py
  '';

  checkInputs = [ vapoursynth ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "adjust" ];

  meta = with lib; {
    description = "A VapourSynth port of the Avisynth filter Tweak";
    homepage = "https://github.com/dubhater/vapoursynth-adjust";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

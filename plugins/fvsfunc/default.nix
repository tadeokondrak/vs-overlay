{ buildPythonPackage
, fetchFromGitHub
, lib
, python3
, vapoursynth
, vapoursynthPlugins
}:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    bilateral
    descale
    dfttest
    fmtconv
    nnedi3
  ];
in
buildPythonPackage rec {
  pname = "fvsfunc";
  version = "unstable-2020-10-12";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "96211df1eb46cda49ffbf1c930d627fe3a5d5d5a";
    sha256 = "0zyb96izws9lb53wlxx9p1ing5z9xy9gj98pblx4p5myim39xywq";
  };

  propagatedBuildInputs = (with vapoursynthPlugins; [
    havsfunc
    muvsfunc
    mvsfunc
    nnedi3_rpow2
  ]) ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D fvsfunc.py $out/${python3.sitePackages}/fvsfunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "fvsfunc" ];

  meta = with lib; {
    description = "A small collection of VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/fvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

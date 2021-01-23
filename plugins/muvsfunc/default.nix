{ buildPythonPackage
, fetchFromGitHub
, lib
, python3
, vapoursynth
, vapoursynthPlugins
}:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    descale
    histogram
    median
    tcanny
  ];
in
buildPythonPackage rec {
  pname = "muvsfunc";
  version = "unstable-2020-09-09";

  src = fetchFromGitHub {
    owner = "WolframRhodium";
    repo = pname;
    rev = "5b5f245f090b6a4de7910ae6168b3ef0e28d2c70";
    sha256 = "1yyqdmlsvz5p07bvfkf48mggz6cdk199ai2pr2apvgcr2pchxc90";
  };

  propagatedBuildInputs = [
    python3.pkgs.matplotlib
  ] ++ (with vapoursynthPlugins; [
    havsfunc
    mt_lutspa
    mvsfunc
    nnedi3_resample
  ]) ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D muvsfunc.py $out/${python3.sitePackages}/muvsfunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "muvsfunc" ];

  meta = with lib; {
    description = "Muonium’s VapourSynth functions";
    homepage = "https://github.com/WolframRhodium/muvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

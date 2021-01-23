{ buildPythonPackage
, fetchFromGitHub
, lib
, python3
, vapoursynth
, vapoursynthPlugins
}:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    adaptivegrain
    addgrain
    bm3d
    descale
    fmtconv
    knlmeanscl
    retinex
    tcanny
    wwxd
  ];
in
buildPythonPackage rec {
  pname = "kagefunc";
  version = "unstable-2021-01-21";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "a1e89b1dd591bafec3b9f95e0087b096b9b6f9b1";
    sha256 = "0j7n7iz0ksqydjm3jzk2l71a77l9ljm71wg414amdqjcbm5dmsw5";
  };

  patches = [
    ./skip-opencl-test.diff
  ];

  propagatedBuildInputs = (with vapoursynthPlugins; [
    fvsfunc
    mvsfunc
    vsutil
  ]) ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D kagefunc.py $out/${python3.sitePackages}/kagefunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
    python3 tests.py
  '';
  pythonImportsCheck = [ "kagefunc" ];

  meta = with lib; {
    description = "A collection of Vapoursynth functions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/kagefunc";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

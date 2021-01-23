{ buildPythonPackage
, fetchgit
, lib
, python3
, vapoursynth
, vapoursynthPlugins
}:

buildPythonPackage rec {
  pname = "mt_lutspa";
  version = "unstable-2015-10-14";

  src = fetchgit {
    url = "https://gist.github.com/tp7/1e39044e1b660ef0a02c";
    rev = "4ab492db4431bd27466b42d96bc5878db822499e";
    sha256 = "0szws6fcrcgdn31szhrmglpl2kglrglx1bgxd0bjl3r51bxiry12";
  };

  propagatedBuildInputs = [
    python3.pkgs.numpy
  ];

  format = "other";

  installPhase = ''
    install -D mt_lutspa.py $out/${python3.sitePackages}/mt_lutspa.py
  '';

  checkInputs = [ vapoursynth ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "mt_lutspa" ];

  meta = with lib; {
    description = "A vapoursynth plugin to computes the value of a pixel according to its spatial position";
    homepage = "https://gist.github.com/tp7/1e39044e1b660ef0a02c";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

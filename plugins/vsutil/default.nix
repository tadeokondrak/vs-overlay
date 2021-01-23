{ buildPythonPackage
, fetchFromGitHub
, lib
, vapoursynth
}:

buildPythonPackage rec {
  pname = "vsutil";
  version = "0.5.0";

  # there are no tests in the pypi tarball
  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = version;
    sha256 = "0pv3910g5cdx132cq9f3g7rb3yxyxyvw9110vsl196xswkccl8n8";
  };

  patches = [
    # Vapoursynth is not recognised during installation. Since this package
    # provides tests, a dependency problem should be catched by them.
    ./disable-vapoursynth-install-requirement.diff
    # By default, test failure does not fail the build.
    ./fail-tests.diff
  ];

  checkInputs = [ vapoursynth ];

  meta = with lib; {
    description = "A collection of general purpose Vapoursynth functions to be reused in modules and scripts";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vsutil";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

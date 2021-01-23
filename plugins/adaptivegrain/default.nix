{ fetchgit, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "adaptivegrain";
  version = "0.3.1";

  src = fetchgit {
    url = "https://git.kageru.moe/kageru/${pname}";
    rev = version;
    sha256 = "1sds08r7as23x7kgfa0w7sqkmzpc4xbccirxjwynybcm25ixpzb4";
  };

  cargoSha256 = "1sfnqlvrclwmp5y59bs92jwl2pv44lvrqmlwxkws6120haiyh6ih";

  postInstall = ''
    mkdir $out/lib/vapoursynth
    mv $out/lib/libadaptivegrain_rs.so $out/lib/vapoursynth/libadaptivegrain_rs.so
  '';

  meta = with lib; {
    description = "Reimplementation of the adaptive_grain mask as a Vapoursynth plugin";
    homepage = "https://git.kageru.moe/kageru/adaptivegrain";
    license = licenses.mit; # the author packages it himself on AUR where the license is set as MIT
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

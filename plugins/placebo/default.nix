{ fetchFromGitHub
, fetchpatch
, lib
, libplacebo
, meson
, ninja
, pkg-config
, stdenv
, vapoursynth
, vulkan-headers
, vulkan-loader
}:

stdenv.mkDerivation rec {
  pname = "vs-placebo";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "Lypheo";
    repo = pname;
    rev = version;
    sha256 = "079i4ixm6273gy9x80ij7s645v5bm53vczkky5lg4vls5sk00hk2";
    fetchSubmodules = true;
  };

  patches = [
    # fix build with newer libplacebo
    (fetchpatch {
      url = "https://github.com/Lypheo/vs-placebo/commit/d717bb49ce03ea9d67152a7c2e4df026de040c35.diff";
      sha256 = "0phnhpv7alxyw4ki3kj3a19j8qv16hww6gz06lyiyabj20xqibri";
    })
  ];

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [
    libplacebo
    vapoursynth
    vulkan-headers
    vulkan-loader
  ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "A libplacebo-based debanding, scaling and color mapping plugin for VapourSynth";
    homepage = "https://github.com/Lypheo/vs-placebo";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}

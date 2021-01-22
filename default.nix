self: super: {
  vapoursynthPlugins = super.recurseIntoAttrs {
    addgrain = super.callPackage ./plugins/addgrain { };
    autocrop = super.callPackage ./plugins/autocrop { };
    awarpsharp2 = super.callPackage ./plugins/awarpsharp2 { };
    beziercurve = super.callPackage ./plugins/beziercurve { };
    bifrost = super.callPackage ./plugins/bifrost { };
    bilateral = super.callPackage ./plugins/bilateral { };
    bm3d = super.callPackage ./plugins/bm3d { };
    cnr2 = super.callPackage ./plugins/cnr2 { };
    continuityfixer = super.callPackage ./plugins/continuityfixer { };
    descale = super.callPackage ./plugins/descale { };
    fmtconv = super.callPackage ./plugins/fmtconv { };
    eedi2 = super.callPackage ./plugins/eedi2 { };
    eedi3m = super.callPackage ./plugins/eedi3m { };
    f3kdb = super.callPackage ./plugins/f3kdb { };
    ffms2 = super.ffms;
    knlmeanscl = super.callPackage ./plugins/knlmeanscl { };
    retinex = super.callPackage ./plugins/retinex { };
    lsmashsource = super.callPackage ./plugins/lsmashsource { };
    mvtools = super.vapoursynth-mvtools;
    nnedi3 = super.callPackage ./plugins/nnedi3 { };
    sangnom = super.callPackage ./plugins/sangnom { };
    tcanny = super.callPackage ./plugins/tcanny { };
    tnlmeans = super.callPackage ./plugins/tnlmeans { };
    wwxd = super.callPackage ./plugins/wwxd { };
  };
}

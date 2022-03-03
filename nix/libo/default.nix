{ fetchFromGitHub, stdenv, bison, flex, clang}:

stdenv.mkDerivation rec {
  name = "libo-${version}";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "CNMAT";
    repo = "libo";
    rev = "9315cc5f9aba199af66f07fd2f66ddfc0b96bae7";
    sha256 = "01lxl59psvzv2kk8zkxsd4v2i9m6899mbrisgz4vv7kbl7zgabxp";
    # rev = "a0c375fba37cf0cfc78f5d8de34e8dd754e2cae9";
    # sha256 = "1z2xhsmvzc6xk5hvr0g89cpjq9rkqngs8qxsyfw42z91nwkhcav1";
  };

  patches = [
    ./libm.patch
  ];

  buildInputs = [bison flex clang];
  buildPhase = ''
    DYNAMIC=true STATIC=false make linux
  '';

  installPhase = ''
    mkdir -p "$out/lib"
    cp libo.so "$out/lib"

    mkdir -p "$out/include"
    cp *.h "$out/include"

    mkdir -p $out/lib/pkgconfig;

    cat > $out/lib/pkgconfig/libo.pc <<EOF
    Name: libo
    Description: Library for OSC bundles
    Version: ${version}
    Libs: -L$out/lib -lo
    Cflags: -I$out/include
    EOF
  '';
}

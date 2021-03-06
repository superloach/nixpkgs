{ lib, stdenv, fetchFromGitHub, cmake, openssl }:

stdenv.mkDerivation rec {
  pname = "actor-framework";
  version = "0.17.6";

  src = fetchFromGitHub {
    owner = "actor-framework";
    repo = "actor-framework";
    rev = version;
    sha256 = "03pi2jcdvdxncvv3hmzlamask0db1fc5l79k9rgq9agl0swd0mnz";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ openssl ];

  cmakeFlags = [
    "-DCAF_NO_EXAMPLES:BOOL=TRUE"
  ];

  doCheck = true;
  checkTarget = "test";
  preCheck = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH''${LD_LIBRARY_PATH:+:}$PWD/lib
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH''${DYLD_LIBRARY_PATH:+:}$PWD/lib
  '';

  meta = with lib; {
    description = "An open source implementation of the actor model in C++";
    homepage = "http://actor-framework.org/";
    license = licenses.bsd3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ bobakker tobim ];
  };
}

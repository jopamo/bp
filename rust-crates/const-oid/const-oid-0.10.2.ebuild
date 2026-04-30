# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="const-oid"
CRATE_VERSION="0.10.2"
CRATE_CHECKSUM="a6ef517f0926dd24a1582492c791b6a4818a4d94e789a334894aa15b0d12f55c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Const-friendly implementation of the ISO/IEC Object Identifier (OID) standard as defined in ITU X.660, with support for BER/DER encoding/decoding as well as heapless no_std (i.e. embedded) support"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/const-oid"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"db"
)

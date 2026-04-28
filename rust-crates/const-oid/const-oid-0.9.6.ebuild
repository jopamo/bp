# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="const-oid"
CRATE_VERSION="0.9.6"
CRATE_CHECKSUM="c2459377285ad874054d797f3ccebf984978aa39129f6eafde5cdc8315b612f8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Const-friendly implementation of the ISO/IEC Object Identifier (OID) standard as defined in ITU X.660, with support for BER/DER encoding/decoding as well as heapless no_std (i.e. embedded) support"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/const-oid"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"db"
	"std"
)

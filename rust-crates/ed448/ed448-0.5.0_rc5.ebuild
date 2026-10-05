# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ed448"
CRATE_VERSION="0.5.0-rc.5"
CRATE_CHECKSUM="8a6517ef61d12c57c218393995d2ee5ab2dac4c27501d24f7595590e097985c9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Edwards Digital Signature Algorithm (EdDSA) over Curve448 (as specified in RFC8032) support library providing signature type definitions and PKCS#8 private key decoding/encoding support"
HOMEPAGE="https://github.com/RustCrypto/signatures/tree/master/ed448"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"pem"
	"serde_bytes"
)

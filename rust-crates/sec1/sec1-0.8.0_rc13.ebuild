# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="sec1"
CRATE_VERSION="0.8.0-rc.13"
CRATE_CHECKSUM="7a2400ed44a13193820aa528a19f376c3843141a8ce96ff34b11104cc79763f2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of SEC1: Elliptic Curve Cryptography encoding formats including ASN.1 DER-serialized private keys as well as the Elliptic-Curve-Point-to-Octet-String encoding"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/sec1"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"der"
	"pem"
	"point"
	"serde"
	"std"
	"zeroize"
)

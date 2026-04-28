# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sec1"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="d3e97a565f76233a6003f9f5c54be1d9c5bdfa3eccfb189469f11ec4901c47dc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of SEC1: Elliptic Curve Cryptography encoding formats including ASN.1 DER-serialized private keys as well as the Elliptic-Curve-Point-to-Octet-String encoding"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/sec1"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
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

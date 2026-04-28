# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ed25519"
CRATE_VERSION="2.2.3"
CRATE_CHECKSUM="115531babc129696a58c64a4fef0a8bf9e9698629fb97e9e40767d235cfbcd53"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Edwards Digital Signature Algorithm (EdDSA) over Curve25519 (as specified in RFC 8032) support library providing signature type definitions and PKCS#8 private key decoding/encoding support"
HOMEPAGE="https://github.com/RustCrypto/signatures/tree/master/ed25519"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"pem"
	"serde_bytes"
	"std"
)

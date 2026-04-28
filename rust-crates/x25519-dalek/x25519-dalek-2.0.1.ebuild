# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="x25519-dalek"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="c7e468321c81fb07fa7f4c636c3972b9100f0346e5b6a9f2bd0603a52f7ed277"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="X25519 elliptic curve Diffie-Hellman key exchange in pure-Rust, using curve25519-dalek."
HOMEPAGE="https://github.com/dalek-cryptography/curve25519-dalek"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"getrandom"
	"precomputed-tables"
	"reusable_secrets"
	"serde"
	"static_secrets"
	"zeroize"
)

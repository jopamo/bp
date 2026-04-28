# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="aes-kw"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="69fa2b352dcefb5f7f3a5fb840e02665d311d878955380515e4fd50095dd3d8c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="NIST 800-38F AES Key Wrap (KW) and Key Wrap with Padding (KWP) modes"
HOMEPAGE="https://github.com/RustCrypto/key-wraps/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
)

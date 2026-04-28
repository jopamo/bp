# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rsa"
CRATE_VERSION="0.9.6"
CRATE_CHECKSUM="5d0e5124fcb30e76a7e79bfee683a2746db83784b86289f6251b54b7950a0dfc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust RSA implementation"
HOMEPAGE="https://github.com/RustCrypto/RSA"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"getrandom"
	"hazmat"
	"nightly"
	"pem"
	"pkcs5"
	"serde"
	"std"
	"u64_digit"
)

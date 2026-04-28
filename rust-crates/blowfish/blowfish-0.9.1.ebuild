# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="blowfish"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="e412e2cd0f2b2d93e02543ceae7917b3c70331573df19ee046bcbc35e45e87d7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Blowfish block cipher"
HOMEPAGE="https://github.com/RustCrypto/block-ciphers"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bcrypt"
	"zeroize"
)

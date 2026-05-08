# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="blowfish"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="62ce3946557b35e71d1bbe07ec385073ce9eda05043f95de134eb578fcf1a298"
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

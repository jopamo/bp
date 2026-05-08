# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bcrypt-pbkdf"
CRATE_VERSION="0.11.0"
CRATE_CHECKSUM="144e573728da132683b9488acd528274c790e07fc06ff81ee29f9d8f8b1041e0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="bcrypt-pbkdf password-based key derivation function"
HOMEPAGE="https://github.com/RustCrypto/password-hashes/tree/master/bcrypt-pbkdf"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"zeroize"
)

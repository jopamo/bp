# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pbkdf2"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="112d82ceb8c5bf524d9af484d4e4970c9fd5a0cc15ba14ad93dccd28873b0629"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generic implementation of PBKDF2"
HOMEPAGE="https://github.com/RustCrypto/password-hashes/tree/master/pbkdf2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"getrandom"
	"kdf"
	"mcf"
	"phc"
	"rand_core"
	"sha2"
)

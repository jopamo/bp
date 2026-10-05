# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="argon2"
CRATE_VERSION="0.6.0-rc.8"
CRATE_CHECKSUM="7af50940b73bf4e16c15c448a2b121c63f2d68e3e54b6a8731673cb4aa0cdff5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Argon2 password hashing function with support for the Argon2d, Argon2i, and Argon2id algorithmic variants"
HOMEPAGE="https://github.com/RustCrypto/password-hashes/tree/master/argon2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"getrandom"
	"kdf"
	"parallel"
	"password-hash"
	"rand_core"
	"zeroize"
)

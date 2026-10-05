# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="phc"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="44dc769b75f93afdddd8c7fa12d685292ddeff1e66f7f0f3a234cf1818afe892"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Password Hashing Competition (PHC) string format which is used for storing password hashes"
HOMEPAGE="https://github.com/RustCrypto/formats"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"getrandom"
	"rand_core"
)

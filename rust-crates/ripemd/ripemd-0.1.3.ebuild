# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ripemd"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="bd124222d17ad93a644ed9d011a40f4fb64aa54275c08cc216524a9ea82fb09f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the RIPEMD hash functions"
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"oid"
	"std"
)

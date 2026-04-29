# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="cc"
CRATE_VERSION="1.2.37"
CRATE_CHECKSUM="65193589c6404eb80b450d618eaf9a2cafaaafd57ecce47370519ef674a7bd44"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A build-time dependency for Cargo build scripts to assist in invoking the native C compiler to compile native C code into a static archive to be linked into Rust code."
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"jobserver"
	"parallel"
)

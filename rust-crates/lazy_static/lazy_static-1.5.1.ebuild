# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="lazy_static"
CRATE_VERSION="1.5.1"
CRATE_CHECKSUM="20870f649af7073d53e38067b2a84312175d56ea15217e1b15bc83506ec50afb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro for declaring lazily evaluated statics in Rust."
HOMEPAGE="https://github.com/rust-lang-nursery/lazy-static.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"spin_no_std"
)

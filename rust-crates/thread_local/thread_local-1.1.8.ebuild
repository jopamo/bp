# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thread_local"
CRATE_VERSION="1.1.8"
CRATE_CHECKSUM="8b9ef9bad013ada3808854ceac7b46812a6465ba368859a37e2100283d2d719c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Per-object thread-local storage"
HOMEPAGE="https://github.com/Amanieu/thread_local-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)

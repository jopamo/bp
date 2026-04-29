# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="crossbeam-utils"
CRATE_VERSION="0.8.21"
CRATE_CHECKSUM="d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for concurrent programming"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"std"
)

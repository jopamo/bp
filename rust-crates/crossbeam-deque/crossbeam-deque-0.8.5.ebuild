# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crossbeam-deque"
CRATE_VERSION="0.8.5"
CRATE_CHECKSUM="613f8cc01fe9cf1a3eb3d7f488fd2fa8388403e97039e2f73692932e291a770d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Concurrent work-stealing deque"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-deque"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)

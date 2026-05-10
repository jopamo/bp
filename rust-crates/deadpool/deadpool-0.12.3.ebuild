# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deadpool"
CRATE_VERSION="0.12.3"
CRATE_CHECKSUM="0be2b1d1d6ec8d846f05e137292d0b89133caf95ef33695424c09568bdd39b1b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Dead simple async pool"
HOMEPAGE="https://github.com/bikeshedder/deadpool"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"managed"
	"rt_async-std_1"
	"rt_tokio_1"
	"unmanaged"
)

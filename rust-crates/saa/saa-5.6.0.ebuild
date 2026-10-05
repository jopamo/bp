# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="saa"
CRATE_VERSION="5.6.0"
CRATE_CHECKSUM="68f5acb362a0e75c2a963532fa7fabf13dff81626dc494df16488d30befcbea0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Word-sized low-level synchronization primitives providing both asynchronous and synchronous interfaces."
HOMEPAGE="https://codeberg.org/wvwwvwwv/synchronous-and-asynchronous"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"lock_api"
	"loom"
)

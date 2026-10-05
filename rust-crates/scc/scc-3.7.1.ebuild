# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="scc"
CRATE_VERSION="3.7.1"
CRATE_CHECKSUM="5bcd12b6caff5213cc3c03123cde8c3db5e413008a63b0c0ba35e6275825ea92"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of high-performance asynchronous/concurrent containers with both asynchronous and synchronous interfaces"
HOMEPAGE="https://codeberg.org/wvwwvwwv/scalable-concurrent-containers/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"loom"
)

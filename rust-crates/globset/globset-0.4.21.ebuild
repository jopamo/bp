# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="globset"
CRATE_VERSION="0.4.21"
CRATE_CHECKSUM="f98b0d85522dc0a824cfebbc9594ff4a9b289c568bea0370319dfbdf20ccdd2d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross platform single glob and glob set matching. Glob set matching is the process of matching one or more glob patterns against a single candidate path simultaneously, and returning all of the globs that matched."
HOMEPAGE="https://github.com/BurntSushi/ripgrep/tree/master/crates/globset"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"default"
	"serde1"
	"simd-accel"
)

# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="globset"
CRATE_VERSION="0.4.16"
CRATE_CHECKSUM="54a1028dfc5f5df5da8a56a73e6c153c9a9708ec57232470703592a3f18e49f5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross platform single glob and glob set matching. Glob set matching is the process of matching one or more glob patterns against a single candidate path simultaneously, and returning all of the globs that matched."
HOMEPAGE="https://github.com/BurntSushi/ripgrep/tree/master/crates/globset"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde1"
	"simd-accel"
)

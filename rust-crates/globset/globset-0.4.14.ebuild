# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="globset"
CRATE_VERSION="0.4.14"
CRATE_CHECKSUM="57da3b9b5b85bd66f31093f8c408b90a74431672542466497dcbdfdc02034be1"
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

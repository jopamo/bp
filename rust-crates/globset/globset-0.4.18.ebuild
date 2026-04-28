# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="globset"
CRATE_VERSION="0.4.18"
CRATE_CHECKSUM="52dfc19153a48bde0cbd630453615c8151bce3a5adfac7a0aebfbf0a1e1f57e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross platform single glob and glob set matching. Glob set matching is the process of matching one or more glob patterns against a single candidate path simultaneously, and returning all of the globs that matched."
HOMEPAGE="https://github.com/BurntSushi/ripgrep/tree/master/crates/globset"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"default"
	"serde1"
	"simd-accel"
)

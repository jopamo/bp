# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="heapless"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="0bfb9eb618601c89945a70e254898da93b13be0388091d42117462b265bb3fad"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="`static` friendly data structures that don't require dynamic memory allocation"
HOMEPAGE="https://github.com/rust-embedded/heapless"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"defmt-03"
	"mpmc_large"
	"portable-atomic"
	"portable-atomic-critical-section"
	"portable-atomic-unsafe-assume-single-core"
	"serde"
	"ufmt"
)

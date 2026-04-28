# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_allocator"
CRATE_VERSION="4.0.1"
CRATE_CHECKSUM="9d7eefd2c8b228a8c73056482b2ae4b3a1071fbe07638e3b55ceca8570cc48bb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A thin wrapper for bumpalo"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"hashbrown"
	"nightly"
	"rkyv"
	"serde"
	"skip-warning"
)

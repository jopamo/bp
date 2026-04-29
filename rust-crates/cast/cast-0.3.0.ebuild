# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cast"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ergonomic, checked cast functions for primitive types"
HOMEPAGE="https://github.com/japaric/cast.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)

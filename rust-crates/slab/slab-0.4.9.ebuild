# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="slab"
CRATE_VERSION="0.4.9"
CRATE_CHECKSUM="8f92a496fb766b417c996b9c5e57daf2f7ad3b0bebe1ccfca4856390e3d3bb67"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pre-allocated storage for a uniform data type"
HOMEPAGE="https://github.com/tokio-rs/slab"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)

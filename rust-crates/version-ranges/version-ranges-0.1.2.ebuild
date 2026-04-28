# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="version-ranges"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="3595ffe225639f1e0fd8d7269dcc05d2fbfea93cfac2fea367daf1adb60aae91"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Performance-optimized type for generic version ranges and operations on them."
HOMEPAGE="https://github.com/pubgrub-rs/pubgrub"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)

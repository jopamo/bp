# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="indexmap"
CRATE_VERSION="2.13.0"
CRATE_CHECKSUM="7714e70437a7dc3ac8eb7e6f8df75fd8eb422675fc7678aff7364301092b1017"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A hash table with consistent order and fast iteration."
HOMEPAGE="https://github.com/indexmap-rs/indexmap"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
	"test_debug"
)

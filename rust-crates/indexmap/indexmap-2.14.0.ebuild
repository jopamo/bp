# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="indexmap"
CRATE_VERSION="2.14.0"
CRATE_CHECKSUM="d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9"
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

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="salsa"
CRATE_VERSION="0.25.2"
CRATE_CHECKSUM="e2e2aa2fca57727371eeafc975acc8e6f4c52f8166a78035543f6ee1c74c2dcc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generic framework for on-demand, incrementalized computation (experimental)"
HOMEPAGE="https://github.com/salsa-rs/salsa"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"accumulator"
	"default"
	"inventory"
	"macros"
	"persistence"
	"salsa_unstable"
	"shuttle"
)

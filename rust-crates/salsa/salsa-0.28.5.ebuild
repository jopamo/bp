# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="salsa"
CRATE_VERSION="0.28.5"
CRATE_CHECKSUM="27d2e6e19e39591cd99c01ac4141544b4d012cfd0831348629b8187fa9fe6d34"
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
	"detailed-trace"
	"inventory"
	"macros"
	"persistence"
	"salsa_unstable"
	"shuttle"
)

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="salsa"
CRATE_VERSION="0.28.2"
CRATE_CHECKSUM="cf0e374215cd2db2b5c75d7b3a99cb0cc052c0595335dfdefc03d4eb08f4aa81"
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

# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="rpds"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="9e75f485e819d4d3015e6c0d55d02a4fd3db47c1993d9e603e0361fba2bffb34"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Persistent data structures with structural sharing"
HOMEPAGE="https://github.com/orium/rpds"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rayon"
	"std"
)

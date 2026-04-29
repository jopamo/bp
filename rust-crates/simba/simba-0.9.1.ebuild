# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="simba"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="c99284beb21666094ba2b75bbceda012e610f5479dfcc2d6e2426f53197ffd95"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SIMD algebra for Rust"
HOMEPAGE="https://github.com/dimforge/simba"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"libm"
	"partial_fixed_point_support"
	"portable_simd"
	"rkyv-serialize"
	"serde_serialize"
	"std"
)

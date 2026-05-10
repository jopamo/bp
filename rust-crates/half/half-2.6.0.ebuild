# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="half"
CRATE_VERSION="2.6.0"
CRATE_CHECKSUM="459196ed295495a68f7d7fe1d84f6c4b7ff0e21fe3017b2f283c6fac3ad803c9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Half-precision floating point f16 and bf16 types for Rust implementing the IEEE 754-2008 standard binary16 and bfloat16 types."
HOMEPAGE="https://github.com/VoidStarKat/half-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"rand_distr"
	"std"
	"use-intrinsics"
)

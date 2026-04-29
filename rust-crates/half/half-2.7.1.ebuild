# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="half"
CRATE_VERSION="2.7.1"
CRATE_CHECKSUM="6ea2d84b969582b4b1864a92dc5d27cd2b77b622a8d79306834f1be5ba20d84b"
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
	"nightly"
	"rand_distr"
	"std"
	"use-intrinsics"
	"zerocopy"
)

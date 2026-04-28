# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-complex"
CRATE_VERSION="0.4.6"
CRATE_CHECKSUM="73f88a1307638156682bada9d7604135552957b7818057dcef22705b4d509495"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Complex numbers implementation for Rust"
HOMEPAGE="https://github.com/rust-num/num-complex"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bytecheck"
	"bytemuck"
	"default"
	"libm"
	"rand"
	"rkyv"
	"serde"
	"std"
)

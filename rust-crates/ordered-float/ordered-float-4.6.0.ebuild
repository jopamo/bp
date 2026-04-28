# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ordered-float"
CRATE_VERSION="4.6.0"
CRATE_CHECKSUM="7bb71e1b3fa6ca1c61f383464aaf2bb0e2f8e772a1f01d486832464de363b951"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wrappers for total ordering on floats"
HOMEPAGE="https://github.com/reem/rust-ordered-float"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"libm"
	"randtest"
	"rkyv"
	"rkyv_16"
	"rkyv_32"
	"rkyv_64"
	"rkyv_ck"
	"serde"
	"std"
)

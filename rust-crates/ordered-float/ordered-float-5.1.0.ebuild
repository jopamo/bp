# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ordered-float"
CRATE_VERSION="5.1.0"
CRATE_CHECKSUM="7f4779c6901a562440c3786d08192c6fbda7c1c2060edd10006b05ee35d10f2d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wrappers for total ordering on floats"
HOMEPAGE="https://github.com/reem/rust-ordered-float"
LICENSE="MIT"
SLOT="${PV}"
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

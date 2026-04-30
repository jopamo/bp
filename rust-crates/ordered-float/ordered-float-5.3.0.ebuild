# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ordered-float"
CRATE_VERSION="5.3.0"
CRATE_CHECKSUM="b7d950ca161dc355eaf28f82b11345ed76c6e1f6eb1f4f4479e0323b9e2fbd0e"
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
	"rkyv_08"
	"rkyv_08_16"
	"rkyv_08_32"
	"rkyv_08_64"
	"rkyv_08_ck"
	"rkyv_16"
	"rkyv_32"
	"rkyv_64"
	"rkyv_ck"
	"serde"
	"std"
)

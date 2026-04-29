# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="num-traits"
CRATE_VERSION="0.2.19"
CRATE_CHECKSUM="071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Numeric traits for generic mathematics"
HOMEPAGE="https://github.com/rust-num/num-traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"i128"
	"libm"
	"std"
)

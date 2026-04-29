# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="constant_time_eq"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="3d52eff69cd5e647efe296129160853a42795992097e8af39800e1060caeea9b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Compares two equal-sized byte strings in constant time."
HOMEPAGE="https://github.com/cesarb/constant_time_eq"
LICENSE="|| ( CC0-1.0 MIT-0 Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"count_instructions_test"
	"default"
	"std"
)

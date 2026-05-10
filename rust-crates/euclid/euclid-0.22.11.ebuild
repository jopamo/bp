# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="euclid"
CRATE_VERSION="0.22.11"
CRATE_CHECKSUM="ad9cdb4b747e485a12abb0e6566612956c7a1bafa3bdb8d682c5b6d403589e48"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Geometry primitives"
HOMEPAGE="https://github.com/servo/euclid"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"libm"
	"std"
	"unstable"
)

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="interpolator"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="71dd52191aae121e8611f1e8dc3e324dd0dd1dee1e6dd91d10ee07a3cfb4d9d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="runtime format strings, fully compatible with std's macros"
HOMEPAGE="https://github.com/ModProg/interpolator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"iter"
	"number"
	"pointer"
)

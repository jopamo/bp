# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="timezone_provider"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="c48f9b04628a2b813051e4dfe97c65281e49625eabd09ec343190e31e399a8c2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Time zone data providers"
HOMEPAGE="https://github.com/boa-dev/temporal"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"datagen"
	"default"
	"experimental_tzif"
	"std"
	"tzif"
	"zoneinfo64"
)

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="time-core"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate is an implementation detail and should not be relied upon directly."
HOMEPAGE="https://github.com/time-rs/time"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"large-dates"
)

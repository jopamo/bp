# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="temporal_capi"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="8a2a1f001e756a9f5f2d175a9965c4c0b3a054f09f30de3a75ab49765f2deb36"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="C interface to temporal_rs"
HOMEPAGE="https://github.com/boa-dev/temporal"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
	"zoneinfo64"
)

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="windows-numerics"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="9150af68066c4c5c07ddc0ce30421554771e528bde427614c61038bc2c92c2b1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Windows numeric types"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)

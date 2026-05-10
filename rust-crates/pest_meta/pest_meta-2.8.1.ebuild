# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pest_meta"
CRATE_VERSION="2.8.1"
CRATE_CHECKSUM="edd1101f170f5903fde0914f899bb503d9ff5271d7ba76bbb70bea63690cc0d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="pest meta language parser and validator"
HOMEPAGE="https://pest.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"grammar-extras"
	"not-bootstrap-in-src"
)

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pest_meta"
CRATE_VERSION="2.8.6"
CRATE_CHECKSUM="89815c69d36021a140146f26659a81d6c2afa33d216d736dd4be5381a7362220"
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

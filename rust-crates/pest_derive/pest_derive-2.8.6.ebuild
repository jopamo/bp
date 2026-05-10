# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pest_derive"
CRATE_VERSION="2.8.6"
CRATE_CHECKSUM="11f486f1ea21e6c10ed15d5a7c77165d0ee443402f0780849d1768e7d9d6fe77"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="pest's derive macro"
HOMEPAGE="https://pest.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"grammar-extras"
	"not-bootstrap-in-src"
	"std"
)

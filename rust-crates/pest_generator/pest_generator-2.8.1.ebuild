# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pest_generator"
CRATE_VERSION="2.8.1"
CRATE_CHECKSUM="87e404e638f781eb3202dc82db6760c8ae8a1eeef7fb3fa8264b2ef280504966"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="pest code generator"
HOMEPAGE="https://pest.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"export-internal"
	"grammar-extras"
	"not-bootstrap-in-src"
	"std"
)

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pest_generator"
CRATE_VERSION="2.8.6"
CRATE_CHECKSUM="8040c4647b13b210a963c1ed407c1ff4fdfa01c31d6d2a098218702e6664f94f"
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

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pest_derive"
CRATE_VERSION="2.8.1"
CRATE_CHECKSUM="bb056d9e8ea77922845ec74a1c4e8fb17e7c218cc4fc11a15c5d25e189aa40bc"
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

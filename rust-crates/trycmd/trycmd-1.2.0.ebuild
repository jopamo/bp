# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="trycmd"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="218889993f76bda9b2ef57c12c3cab0eef4fd54ec7b36d1704849867f69e7bb4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Snapshot testing for a herd of CLI tests"
HOMEPAGE="https://github.com/assert-rs/snapbox/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color"
	"color-auto"
	"debug"
	"default"
	"diff"
	"examples"
	"filesystem"
	"schema"
)

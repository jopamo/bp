# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bitflags"
CRATE_VERSION="2.13.0"
CRATE_CHECKSUM="b4388bee8683e3d04af747c73422af53102d2bd24d9eadb6cbc100baef4b43f8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro to generate structures which behave like bitflags."
HOMEPAGE="https://github.com/bitflags/bitflags"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"example_generated"
	"serde"
	"std"
)

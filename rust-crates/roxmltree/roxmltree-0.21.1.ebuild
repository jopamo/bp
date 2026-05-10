# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="roxmltree"
CRATE_VERSION="0.21.1"
CRATE_CHECKSUM="f1964b10c76125c36f8afe190065a4bf9a87bf324842c05701330bba9f1cacbb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Represent an XML as a read-only tree."
HOMEPAGE="https://github.com/RazrFalcon/roxmltree"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"positions"
	"std"
)

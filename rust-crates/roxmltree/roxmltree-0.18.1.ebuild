# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="roxmltree"
CRATE_VERSION="0.18.1"
CRATE_CHECKSUM="862340e351ce1b271a378ec53f304a5558f7db87f3769dc655a8f6ecbb68b302"
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

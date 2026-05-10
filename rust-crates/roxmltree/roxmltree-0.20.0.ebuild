# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="roxmltree"
CRATE_VERSION="0.20.0"
CRATE_CHECKSUM="6c20b6793b5c2fa6553b250154b78d6d0db37e72700ae35fad9387a46f487c97"
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

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="xmlparser"
CRATE_VERSION="0.13.6"
CRATE_CHECKSUM="66fee0b777b0f5ac1c69bb06d361268faafa61cd4682ae064a171c16c433e9e4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pull-based, zero-allocation XML parser."
HOMEPAGE="https://github.com/RazrFalcon/xmlparser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)

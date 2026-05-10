# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-properties"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="7df058c713841ad818f1dc5d3fd88063241cc61f49f5fbea4b951e8cf5a8d71d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Query character Unicode properties according to UAX #44 and UTR #51."
HOMEPAGE="https://github.com/unicode-rs/unicode-properties"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"emoji"
	"general-category"
)

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-bidi"
CRATE_VERSION="0.3.18"
CRATE_CHECKSUM="5c1cb5db39152898a79168971543b1cb5020dff7fe43c8dc468b0885f5e29df5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation of the Unicode Bidirectional Algorithm"
HOMEPAGE="https://github.com/servo/unicode-bidi"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench_it"
	"default"
	"flame_it"
	"hardcoded-data"
	"std"
	"unstable"
	"with_serde"
)

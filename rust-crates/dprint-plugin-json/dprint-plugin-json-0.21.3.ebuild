# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="dprint-plugin-json"
CRATE_VERSION="0.21.3"
CRATE_CHECKSUM="a2fe735acd073034b25ca9868f49b5265ff01a831dff89a2302dbe70178ca1db"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="JSON formatter for dprint."
HOMEPAGE="https://github.com/dprint/dprint-plugin-json"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"tracing"
	"wasm"
)

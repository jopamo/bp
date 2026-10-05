# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quick-xml"
CRATE_VERSION="0.39.4"
CRATE_CHECKSUM="cdcc8dd4e2f670d309a5f0e83fe36dfdc05af317008fea29144da1a2ac858e5e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="High performance xml reader and writer"
HOMEPAGE="https://github.com/tafia/quick-xml"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-tokio"
	"default"
	"encoding"
	"escape-html"
	"overlapped-lists"
	"serde-types"
	"serialize"
)

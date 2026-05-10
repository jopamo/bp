# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quick-xml"
CRATE_VERSION="0.38.3"
CRATE_CHECKSUM="42a232e7487fc2ef313d96dde7948e7a3c05101870d8985e4fd8d26aedd27b89"
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

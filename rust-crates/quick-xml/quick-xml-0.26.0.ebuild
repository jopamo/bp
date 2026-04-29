# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="quick-xml"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="7f50b1c63b38611e7d4d7f68b82d3ad0cc71a2ad2e7f61fc10f1328d917c93cd"
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
	"serialize"
)

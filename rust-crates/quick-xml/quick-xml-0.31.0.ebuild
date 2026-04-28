# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quick-xml"
CRATE_VERSION="0.31.0"
CRATE_CHECKSUM="1004a344b30a54e2ee58d66a71b32d2db2feb0a31f9a2d302bf0536f15de2a33"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="High performance xml reader and writer"
HOMEPAGE="https://github.com/tafia/quick-xml"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"async-tokio"
	"default"
	"encoding"
	"escape-html"
	"overlapped-lists"
	"serde-types"
	"serialize"
)

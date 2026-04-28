# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quick-xml"
CRATE_VERSION="0.37.5"
CRATE_CHECKSUM="331e97a1af0bf59823e6eadffe373d7b27f485be8748f71471c662c1f269b7fb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="High performance xml reader and writer"
HOMEPAGE="https://github.com/tafia/quick-xml"
LICENSE="MIT"
SLOT="0/${PV}"
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

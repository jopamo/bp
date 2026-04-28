# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="asynchronous-codec"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="a860072022177f903e59730004fb5dc13db9275b79bb2aef7ba8ce831956c233"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for encoding and decoding frames using `async/await`"
HOMEPAGE="https://github.com/mxinden/asynchronous-codec"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"cbor"
	"default"
	"json"
)

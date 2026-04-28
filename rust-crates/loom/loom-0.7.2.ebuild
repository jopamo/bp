# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="loom"
CRATE_VERSION="0.7.2"
CRATE_CHECKSUM="419e0dc8046cb947daa77eb95ae174acfbddb7673b4151f56d1eed8e93fbfaca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Permutation testing for concurrent code"
HOMEPAGE="https://github.com/tokio-rs/loom"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"checkpoint"
	"default"
	"futures"
)

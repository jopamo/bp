# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing-core"
CRATE_VERSION="0.1.33"
CRATE_CHECKSUM="e672c95779cf947c5311f83787af4fa8fffd12fb27e4993211a84bdfd9610f9c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core primitives for application-level tracing."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)

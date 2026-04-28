# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="h2"
CRATE_VERSION="0.4.7"
CRATE_CHECKSUM="ccae279728d634d083c00f6099cb58f01cc99c145b84b8be2f6c74618d79922e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An HTTP/2 client and server"
HOMEPAGE="https://github.com/hyperium/h2"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"stream"
	"unstable"
)

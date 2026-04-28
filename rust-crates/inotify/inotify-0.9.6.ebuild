# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="inotify"
CRATE_VERSION="0.9.6"
CRATE_CHECKSUM="f8069d3ec154eb856955c1c0fbffefbf5f3c40a104ec912d4797314c1801abff"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Idiomatic wrapper for inotify"
HOMEPAGE="https://github.com/hannobraun/inotify"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"stream"
)

# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="inotify"
CRATE_VERSION="0.11.0"
CRATE_CHECKSUM="f37dccff2791ab604f9babef0ba14fbe0be30bd368dc541e2b08d07c8aa908f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Idiomatic wrapper for inotify"
HOMEPAGE="https://github.com/hannobraun/inotify"
LICENSE="ISC"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"stream"
)

# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="inotify"
CRATE_VERSION="0.11.5"
CRATE_CHECKSUM="4cc00ea907cab49550b7da656f80ebb97be1b997d931fbcd28d39734e17ce592"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Idiomatic wrapper for inotify"
HOMEPAGE="https://github.com/hannobraun/inotify-rs"
LICENSE="ISC"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"stream"
)

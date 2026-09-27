# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="inotify-sys"
CRATE_VERSION="0.1.8"
CRATE_CHECKSUM="c033f80b2c113cdf91ab7a33faa9cbc014726dcad99880c8609af2a370edf37d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="inotify bindings for the Rust programming language"
HOMEPAGE="https://github.com/hannobraun/inotify-sys"
LICENSE="ISC"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"freebsd-native"
)

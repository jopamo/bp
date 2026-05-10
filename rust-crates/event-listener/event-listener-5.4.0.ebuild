# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="event-listener"
CRATE_VERSION="5.4.0"
CRATE_CHECKSUM="3492acde4c3fc54c845eaab3eed8bd00c7a7d881f78bfc801e43a93dec1331ae"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Notify async tasks or threads"
HOMEPAGE="https://github.com/smol-rs/event-listener"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"loom"
	"portable-atomic"
	"std"
)

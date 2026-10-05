# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async-task"
CRATE_VERSION="4.7.1"
CRATE_CHECKSUM="8b75356056920673b02621b35afd0f7dda9306d03c79a30f5c56c44cf256e3de"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Task abstraction for building executors"
HOMEPAGE="https://github.com/smol-rs/async-task"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)

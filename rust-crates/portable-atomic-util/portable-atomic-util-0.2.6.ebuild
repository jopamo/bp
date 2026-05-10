# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="portable-atomic-util"
CRATE_VERSION="0.2.6"
CRATE_CHECKSUM="091397be61a01d4be58e7841595bd4bfedb15f1cd54977d79b8271e94ed799a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Synchronization primitives built with portable-atomic."
HOMEPAGE="https://github.com/taiki-e/portable-atomic-util"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)

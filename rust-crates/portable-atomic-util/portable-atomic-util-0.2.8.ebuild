# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="portable-atomic-util"
CRATE_VERSION="0.2.8"
CRATE_CHECKSUM="10ab3eb7f3becc3a1cbc4f2c6f20267996cfc1a6467a873763411b136a122715"
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

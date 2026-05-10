# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="temp-env"
CRATE_VERSION="0.3.6"
CRATE_CHECKSUM="96374855068f47402c3121c6eed88d29cb1de8f3ab27090e273e420bdabcf050"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Set environment variables temporarily."
HOMEPAGE="https://github.com/vmx/temp-env"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async_closure"
	"default"
)

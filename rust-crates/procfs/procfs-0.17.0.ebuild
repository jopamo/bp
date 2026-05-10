# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="procfs"
CRATE_VERSION="0.17.0"
CRATE_CHECKSUM="cc5b72d8145275d844d4b5f6d4e1eef00c8cd889edb6035c21675d1bb1f45c9f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Interface to the linux procfs pseudo-filesystem"
HOMEPAGE="https://github.com/eminence/procfs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"backtrace"
	"default"
	"serde1"
)

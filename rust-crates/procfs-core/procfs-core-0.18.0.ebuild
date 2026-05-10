# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="procfs-core"
CRATE_VERSION="0.18.0"
CRATE_CHECKSUM="e6401bf7b6af22f78b563665d15a22e9aef27775b79b149a66ca022468a4e405"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data structures and parsing for the linux procfs pseudo-filesystem"
HOMEPAGE="https://github.com/eminence/procfs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde1"
)

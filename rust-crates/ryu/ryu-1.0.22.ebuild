# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ryu"
CRATE_VERSION="1.0.22"
CRATE_CHECKSUM="a50f4cf475b65d88e057964e0e9bb1f0aa9bbb2036dc65c64596b42932536984"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast floating point to string conversion"
HOMEPAGE="https://github.com/dtolnay/ryu"
LICENSE="|| ( Apache-2.0 BSL-1.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"small"
)

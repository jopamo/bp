# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="serde_path_to_error"
CRATE_VERSION="0.1.20"
CRATE_CHECKSUM="10a9ff822e371bb5403e391ecd83e182e0e77ba7f6fe0160b795797109d1b457"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Path to the element that failed to deserialize"
HOMEPAGE="https://github.com/dtolnay/path-to-error"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

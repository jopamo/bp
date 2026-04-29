# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tonic-prost"
CRATE_VERSION="0.14.5"
CRATE_CHECKSUM="a55376a0bbaa4975a3f10d009ad763d8f4108f067c7c2e74f3001fb49778d309"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Prost codec implementation for tonic"
HOMEPAGE="https://github.com/hyperium/tonic"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

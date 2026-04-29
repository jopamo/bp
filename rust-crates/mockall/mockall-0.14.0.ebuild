# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="mockall"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="f58d964098a5f9c6b63d0798e5372fd04708193510a7af313c22e9f29b7b620b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A powerful mock object library for Rust."
HOMEPAGE="https://github.com/asomers/mockall"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)

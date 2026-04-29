# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="monostate-impl"
CRATE_VERSION="0.1.18"
CRATE_CHECKSUM="e4db6d5580af57bf992f59068d4ea26fd518574ff48d7639b255a36f9de6e7e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the monostate crate"
HOMEPAGE="https://github.com/dtolnay/monostate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

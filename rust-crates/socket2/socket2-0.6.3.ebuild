# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="socket2"
CRATE_VERSION="0.6.3"
CRATE_CHECKSUM="3a766e1110788c36f4fa1c2b71b387a7815aa65f88ce0229841826633d93723e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for handling networking sockets with a maximal amount of configuration possible intended."
HOMEPAGE="https://github.com/rust-lang/socket2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
)

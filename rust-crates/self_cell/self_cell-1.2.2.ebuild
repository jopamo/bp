# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="self_cell"
CRATE_VERSION="1.2.2"
CRATE_CHECKSUM="b12e76d157a900eb52e81bc6e9f3069344290341720e9178cde2407113ac8d89"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safe-to-use proc-macro-free self-referential structs in stable Rust."
HOMEPAGE="https://github.com/Voultapher/self_cell"
LICENSE="|| ( Apache-2.0 GPL-2.0-only )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"old_rust"
)

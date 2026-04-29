# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="page_size"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="30d5b2194ed13191c1999ae0704b7839fb18384fa22e49b57eeaa97d79ce40da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides an easy, fast, cross-platform way to retrieve the memory page size"
HOMEPAGE="https://github.com/Elzair/page_size_rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no_std"
)

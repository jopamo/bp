# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="idna_adapter"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="daca1df1c957320b2cf139ac61e7bd64fed304c5040df000a745aa1de3b4ef71"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Back end adapter for idna"
HOMEPAGE="https://docs.rs/crate/idna_adapter/latest"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
)

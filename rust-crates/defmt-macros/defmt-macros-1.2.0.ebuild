# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="defmt-macros"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="840bb056bd99c495c9188198a258ab787c79f306d864db3e6e8451442d6d8366"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="defmt macros"
HOMEPAGE="https://github.com/knurling-rs/defmt"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"unstable-test"
)

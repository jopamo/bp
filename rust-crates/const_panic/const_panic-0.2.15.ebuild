# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="const_panic"
CRATE_VERSION="0.2.15"
CRATE_CHECKSUM="e262cdaac42494e3ae34c43969f9cdeb7da178bdb4b66fa6a1ea2edb4c8ae652"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="const panic with formatting"
HOMEPAGE="https://github.com/rodrimati1992/const_panic/"
LICENSE="Zlib"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__ui_tests"
	"default"
	"derive"
	"docsrs"
	"non_basic"
	"rust_1_64"
	"rust_1_82"
	"rust_1_88"
	"rust_latest_stable"
	"test"
)

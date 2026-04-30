# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serial_test_derive"
CRATE_VERSION="3.4.0"
CRATE_CHECKSUM="0a7d91949b85b0d2fb687445e448b40d322b6b3e4af6b44a29b21d9a5f33e6d9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper crate for serial_test"
HOMEPAGE="https://github.com/palfrey/serial_test/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async"
	"default"
	"file_locks"
	"test_logging"
)

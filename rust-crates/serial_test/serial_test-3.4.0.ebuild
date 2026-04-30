# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serial_test"
CRATE_VERSION="3.4.0"
CRATE_CHECKSUM="911bd979bf1070a3f3aa7b691a3b3e9968f339ceeec89e08c280a8a22207a32f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Allows for the creation of serialised Rust tests"
HOMEPAGE="https://github.com/palfrey/serial_test/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async"
	"default"
	"docsrs"
	"file_locks"
	"logging"
	"test_logging"
)

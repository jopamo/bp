# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serial_test"
CRATE_VERSION="3.3.1"
CRATE_CHECKSUM="0d0b343e184fc3b7bb44dff0705fffcf4b3756ba6aff420dddd8b24ca145e555"
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

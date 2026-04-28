# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serial_test_derive"
CRATE_VERSION="3.3.1"
CRATE_CHECKSUM="6f50427f258fb77356e4cd4aa0e87e2bd2c66dbcee41dc405282cae2bfc26c83"
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

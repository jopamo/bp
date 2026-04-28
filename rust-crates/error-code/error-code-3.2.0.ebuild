# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="error-code"
CRATE_VERSION="3.2.0"
CRATE_CHECKSUM="a0474425d51df81997e2f90a21591180b38eccf27292d755f3e30750225c175b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Error code"
HOMEPAGE="https://github.com/DoumanAsh/error-code"
LICENSE="BSL-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)

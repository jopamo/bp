# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_stdx"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="aa770adb32896fcba934b464ac3bd179163ba2b0766e275eed5b4e262e08492b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Missing batteries for standard libraries for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"force-always-assert"
)

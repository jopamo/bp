# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="portable-atomic"
CRATE_VERSION="1.6.0"
CRATE_CHECKSUM="7170ef9988bc169ba16dd36a7fa041e5c4cbeb6a35b76d4c03daded371eae7c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Portable atomic types including support for 128-bit atomics, atomic float, etc."
HOMEPAGE="https://github.com/taiki-e/portable-atomic"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"disable-fiq"
	"fallback"
	"float"
	"force-amo"
	"require-cas"
	"s-mode"
	"std"
	"unsafe-assume-single-core"
)

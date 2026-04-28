# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="portable-atomic"
CRATE_VERSION="1.13.1"
CRATE_CHECKSUM="c33a9471896f1c69cecef8d20cbe2f7accd12527ce60845ff44c153bb2a21b49"
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
	"unsafe-assume-privileged"
	"unsafe-assume-single-core"
)

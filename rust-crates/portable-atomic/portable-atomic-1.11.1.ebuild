# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="portable-atomic"
CRATE_VERSION="1.11.1"
CRATE_CHECKSUM="f84267b20a16ea918e43c6a88433c2d54fa145c92a811b5b047ccbe153674483"
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

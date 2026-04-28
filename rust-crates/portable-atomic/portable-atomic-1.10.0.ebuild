# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="portable-atomic"
CRATE_VERSION="1.10.0"
CRATE_CHECKSUM="280dc24453071f1b63954171985a0b0d30058d287960968b9b2aca264c8d4ee6"
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

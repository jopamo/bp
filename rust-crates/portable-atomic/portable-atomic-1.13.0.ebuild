# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="portable-atomic"
CRATE_VERSION="1.13.0"
CRATE_CHECKSUM="f89776e4d69bb58bc6993e99ffa1d11f228b839984854c7daeb5d37f87cbe950"
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

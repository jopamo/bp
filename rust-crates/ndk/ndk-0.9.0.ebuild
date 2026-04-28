# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ndk"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="c3f42e7bbe13d351b6bead8286a43aac9534b82bd3cc43e47037f012ebfd62d4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safe Rust bindings to the Android NDK"
HOMEPAGE="https://github.com/rust-mobile/ndk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"all"
	"api-level-23"
	"api-level-24"
	"api-level-25"
	"api-level-26"
	"api-level-27"
	"api-level-28"
	"api-level-29"
	"api-level-30"
	"api-level-31"
	"api-level-32"
	"api-level-33"
	"audio"
	"bitmap"
	"default"
	"media"
	"nativewindow"
	"sync"
	"test"
)

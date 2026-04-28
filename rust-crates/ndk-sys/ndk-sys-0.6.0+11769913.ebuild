# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ndk-sys"
CRATE_VERSION="0.6.0+11769913"
CRATE_CHECKSUM="ee6cda3051665f1fb8d9e08fc35c96d5a244fb1be711a03b71118828afc9a873"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings for the Android NDK"
HOMEPAGE="https://github.com/rust-mobile/ndk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"audio"
	"bitmap"
	"media"
	"nativewindow"
	"sync"
	"test"
)

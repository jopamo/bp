# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="android-activity"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="ef6978589202a00cd7e118380c448a08b6ed394c3a8df3a430d0898e3a42d046"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Glue for building Rust applications on Android with NativeActivity or GameActivity"
HOMEPAGE="https://github.com/rust-mobile/android-activity"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"game-activity"
	"native-activity"
)

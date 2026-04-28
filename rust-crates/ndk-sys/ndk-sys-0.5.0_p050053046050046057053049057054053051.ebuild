# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ndk-sys"
CRATE_VERSION="0.5.0+25.2.9519653"
CRATE_CHECKSUM="8c196769dd60fd4f363e11d948139556a344e79d451aeb2fa2fd040738ef7691"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings for the Android NDK"
HOMEPAGE="https://github.com/rust-mobile/ndk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"audio"
	"bitmap"
	"media"
	"sync"
	"test"
)

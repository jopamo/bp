# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="v8"
CRATE_VERSION="140.2.0"
CRATE_CHECKSUM="8827809a2884fb68530d678a8ef15b1ed1344bbf844879194d68c140c6f844f9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to V8"
HOMEPAGE="https://github.com/denoland/rusty_v8"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_custom_libcxx"
	"v8_enable_pointer_compression"
	"v8_enable_v8_checks"
)

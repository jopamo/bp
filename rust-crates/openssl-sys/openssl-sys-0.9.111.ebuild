# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="openssl-sys"
CRATE_VERSION="0.9.111"
CRATE_CHECKSUM="82cab2d520aa75e3c58898289429321eb788c3106963d0dc886ec7a5f4adc321"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings to OpenSSL"
HOMEPAGE="https://github.com/rust-openssl/rust-openssl"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc"
	"aws-lc-fips"
	"unstable_boringssl"
	"vendored"
)

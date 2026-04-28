# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="openssl-sys"
CRATE_VERSION="0.9.108"
CRATE_CHECKSUM="e145e1651e858e820e4860f7b9c5e169bc1d8ce1c86043be79fa7b7634821847"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings to OpenSSL"
HOMEPAGE="https://github.com/sfackler/rust-openssl"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc"
	"unstable_boringssl"
	"vendored"
)

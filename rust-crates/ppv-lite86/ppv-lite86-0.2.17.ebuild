# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ppv-lite86"
CRATE_VERSION="0.2.17"
CRATE_CHECKSUM="5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation of the crypto-simd API for x86"
HOMEPAGE="https://github.com/cryptocorrosion/cryptocorrosion"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"no_simd"
	"simd"
	"std"
)

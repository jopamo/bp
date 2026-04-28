# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-bindgen-rt"
CRATE_VERSION="0.39.0"
CRATE_CHECKSUM="6f42320e61fe2cfd34354ecb597f86f413484a798ba44a8ca1165c58d42da6c1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Runtime support for the `wit-bindgen` crate"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"async"
)

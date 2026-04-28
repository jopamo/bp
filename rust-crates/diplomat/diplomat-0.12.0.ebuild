# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="diplomat"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="ced081520ee8cf2b8c5b64a1a901eccd7030ece670dac274afe64607d6499b71"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The diplomat FFI generation macro"
HOMEPAGE="https://github.com/rust-diplomat/diplomat"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

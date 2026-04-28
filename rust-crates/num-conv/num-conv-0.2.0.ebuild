# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-conv"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="cf97ec579c3c42f953ef76dbf8d55ac91fb219dde70e49aa4a6b7d74e9919050"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="\`num_conv\` is a crate to convert between integer types without using \`as\` casts. This provides better certainty when refactoring, makes the exact behavior of code more explicit, and allows using turbofish syntax."
HOMEPAGE="https://github.com/jhpratt/num-conv"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

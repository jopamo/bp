# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-conv"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="\`num_conv\` is a crate to convert between integer types without using \`as\` casts. This provides better certainty when refactoring, makes the exact behavior of code more explicit, and allows using turbofish syntax."
HOMEPAGE="https://github.com/jhpratt/num-conv"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

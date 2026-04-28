# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerovec-derive"
CRATE_VERSION="0.11.2"
CRATE_CHECKSUM="eadce39539ca5cb3985590102671f2567e659fca9666581ad3411d59207951f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for the zerovec crate"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

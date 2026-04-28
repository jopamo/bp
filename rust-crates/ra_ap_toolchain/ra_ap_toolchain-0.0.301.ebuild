# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_toolchain"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="61969c5f72af03a9837e077c2d939d87a5c863623725c461777c352664a3bb03"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Discovery of \`cargo\` & \`rustc\` executables for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

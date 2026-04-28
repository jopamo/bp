# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cstr"
CRATE_VERSION="0.2.12"
CRATE_CHECKSUM="68523903c8ae5aacfa32a0d9ae60cadeb764e1da14ee0d26b1f3089f13a54636"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for building static CStr reference"
HOMEPAGE="https://github.com/upsuper/cstr"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

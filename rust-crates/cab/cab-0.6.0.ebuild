# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cab"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="171228650e6721d5acc0868a462cd864f49ac5f64e4a42cde270406e64e404d2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Read/write Windows cabinet (CAB) files"
HOMEPAGE="https://github.com/mdsteele/rust-cab"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

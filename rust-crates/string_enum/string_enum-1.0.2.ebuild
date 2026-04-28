# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="string_enum"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="ae36a4951ca7bd1cfd991c241584a9824a70f6aff1e7d4f693fb3f2465e4030e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="String based enum."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

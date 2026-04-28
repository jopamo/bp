# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="difflib"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="6184e33543162437515c2e2b48714794e37845ec9851711914eec9d308f6ebe8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Port of Python's difflib library to Rust."
HOMEPAGE="https://github.com/DimaKudosh/difflib"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sdd"
CRATE_VERSION="3.0.10"
CRATE_CHECKSUM="490dcfcbfef26be6800d11870ff2df8774fa6e86d047e3e8c8a76b25655e41ca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Scalable lock-free delayed memory reclaimer"
HOMEPAGE="https://github.com/wvwwvwwv/scalable-delayed-dealloc/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="kqueue"
CRATE_VERSION="1.0.8"
CRATE_CHECKSUM="7447f1ca1b7b563588a205fe93dea8df60fd981423a768bc1c0ded35ed147d0c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="kqueue interface for BSDs"
HOMEPAGE="https://gitlab.com/rust-kqueue/rust-kqueue"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thiserror-impl"
CRATE_VERSION="2.0.17"
CRATE_CHECKSUM="3ff15c8ecd7de3849db632e14d18d2571fa09dfc5ed93479bc4485c7a517c913"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the `thiserror` crate"
HOMEPAGE="https://github.com/dtolnay/thiserror"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

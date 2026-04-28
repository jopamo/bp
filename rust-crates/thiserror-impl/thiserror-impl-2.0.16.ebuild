# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thiserror-impl"
CRATE_VERSION="2.0.16"
CRATE_CHECKSUM="6c5e1be1c48b9172ee610da68fd9cd2770e7a4056cb3fc98710ee6906f0c7960"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the \`thiserror\` crate"
HOMEPAGE="https://github.com/dtolnay/thiserror"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

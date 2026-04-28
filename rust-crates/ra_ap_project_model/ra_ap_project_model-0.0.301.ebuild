# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_project_model"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="5bda0769fd6ca949fdd5917acb68ddc2c143745614ddd94ef38b376838611cf8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A representation for a Cargo project for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

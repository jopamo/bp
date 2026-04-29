# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerocopy-derive"
CRATE_VERSION="0.8.25"
CRATE_CHECKSUM="28a6e20d751156648aa063f3800b706ee209a32c0b4d9f24be3d980b01be55ef"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for traits from the zerocopy crate"
HOMEPAGE="https://github.com/google/zerocopy"
LICENSE="|| ( BSD-2-Clause Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

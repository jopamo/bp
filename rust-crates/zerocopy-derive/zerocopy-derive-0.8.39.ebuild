# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerocopy-derive"
CRATE_VERSION="0.8.39"
CRATE_CHECKSUM="4122cd3169e94605190e77839c9a40d40ed048d305bfdc146e7df40ab0f3e517"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for traits from the zerocopy crate"
HOMEPAGE="https://github.com/google/zerocopy"
LICENSE="|| ( BSD-2-Clause Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

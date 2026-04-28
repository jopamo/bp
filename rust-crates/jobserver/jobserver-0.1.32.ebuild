# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jobserver"
CRATE_VERSION="0.1.32"
CRATE_CHECKSUM="48d1dbcbbeb6a7fec7e059840aa538bd62aaccf972c7346c4d9d2059312853d0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of the GNU Make jobserver for Rust."
HOMEPAGE="https://github.com/rust-lang/jobserver-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

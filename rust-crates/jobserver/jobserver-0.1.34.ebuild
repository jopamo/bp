# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jobserver"
CRATE_VERSION="0.1.34"
CRATE_CHECKSUM="9afb3de4395d6b3e67a780b6de64b51c978ecf11cb9a462c66be7d4ca9039d33"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of the GNU Make jobserver for Rust."
HOMEPAGE="https://github.com/rust-lang/jobserver-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
